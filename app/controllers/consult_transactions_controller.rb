class ConsultTransactionsController < AuthenticatedResourcesController

  # show all transaction on the perspective of "role"
  def index
    # currently the "role" is a reserved query parameter allowing instructor
    # to view transactions where he is a student.
    @role = params.permit(:role)[:role]
    if !%w(student instructor).include? @role
      @role = InstructorInfo.exists?(current_user.id) ? 'instructor' : 'student'
    end
    @other_role = @role == 'instructor' ? 'student' : 'instructor'
    @transactions_received = ConsultTransaction.where("instructor_id": current_user.id)
    @transactions_placed = ConsultTransaction.where("student_id": current_user.id)
  end

  def create
    # TODO: put privacy_policy into db with versioning
    # TODO: what should we use for hourly_price?
    # TODO: check if instructor has been updated since 'new'
    @transaction = ConsultTransaction.new(transaction_params)
    @transaction.student_id = current_user.id
    @transaction.status = 'initiated'
    if @transaction.save
      TutorMailer.notify_tutor(@transaction.instructor_id, @transaction.student_id).deliver
      flash[:notice] = I18n.t("flash_notice.transaction.save_successful")
      redirect_to(consult_transactions_path)
    else
      render('new')
    end
  end

  def show
    set_transaction_and_role
    gon.opentok_api_key = Rails.application.secrets.tokbox[:api_key]
    # @sender = @transaction.sender
    # @receiver = @transaction.receiver
    gon.token = @transaction.generate_opentok_token
    gon.session_id = @transaction.open_tok_session_id
    @alipay_url = generate_ali_pay_url @transaction
    gon.alipay_url = @alipay_url
    @payment_amount = @transaction.hourly_price
  end

  def update
    set_transaction_and_role
    if invalid_payment_amount?
      redirect_to(consult_transaction_path(@transaction), alert: I18n.t("errors.payment_amount_invalid"))
    else
      if @transaction.update_attributes(transaction_params)
        flash[:notice] = I18n.t("flash_notice.transaction.update_successful")
        if request_aborted?
          TutorMailer.order_decline(@transaction).deliver
          redirect_to(decline_consult_transaction_path)
        else
          # Send Congrat email to student
          TutorMailer.order_confirmation(@transaction, confirm_consult_transaction_path).deliver
          redirect_to(confirm_consult_transaction_path)
        end
      else
        render('show')
      end
    end
  end

  # confirm the transaction depending on what state it is on.
  # transaction is "initiated" when created
  # "initiated" + instructor confirm => "payment_pending"
  # "payment_pending" + instructor confirm (cancel = true) => "initiated"
  # TODO: more state transfer logic should be added
  def confirm
    set_transaction_and_role
    if @self == @transaction.instructor
      if @transaction.status == "initiated"
        if @transaction.update(status: :payment_pending)
          flash[:notice] = I18n.t("flash_notice.transaction.transaction_completed")
        else
          flash[:notice] = I18n.t("flash_notice.transaction.transaction_completed_failed")
        end
      elsif params.permit(:cancel)
        if @transaction.update(status: :initiated)
          flash[:notice] = I18n.t("flash_notice.transaction.transaction_cancelled")
        else
          flash[:notice] = I18n.t("flash_notice.transaction.transaction_cancel_failed")
        end
      else
        flash[:notice] = I18n.t("flash_notice.transaction.transaction_cannot_confirm")
      end
    else
      flash[:notice] = I18n.t("flash_notice.transaction.invalid_operation")
    end
    redirect_to @transaction
  end

  def decline
    set_transaction_and_role
    if @self == @transaction.instructor
      if @transaction.status == "initiated"
        if @transaction.update(status: :aborted)
          flash[:notice] = I18n.t("flash_notice.transaction.transaction_declined")
        else
          flash[:notice] = I18n.t("flash_notice.transaction.transaction_decline_failed")
        end
      else
        flash[:notice] = I18n.t("flash_notice.transaction.transaction_cannot_declined")
      end
    else #student
      if @transaction.status == "payment_pending"
        if @transaction.update(status: :aborted)
          flash[:notice] = I18n.t("flash_notice.transaction.transaction_declined")
        else
          flash[:notice] = I18n.t("flash_notice.transaction.transaction_decline_failed")
        end
      else
        flash[:notice] = I18n.t("flash_notice.transaction.transaction_cannot_declined")
      end
    end
    redirect_to @transaction
  end


  def payment_complete
    set_transaction_and_role
    if @self != @transaction.student
      flash[:notice] = "I am not a student"
      redirect_to @transaction
      return
    end

    if @transaction.update(status: :payment_completed)
      flash[:notice] = I18n.t("flash_notice.transaction.payment_create_succeeded")
    else
      flash[:notice] = I18n.t("flash_notice.transaction.payment_create_failed")
    end
    redirect_to @transaction
  end


  def complete
    set_transaction_and_role
    if @self != @transaction.instructor
      flash[:notice] = "im not an instructor"
      redirect_to @transaction
      return
    end

    if @transaction.update(status: :completed)
      flash[:notice] = I18n.t("flash_notice.transaction.transaction_completed")
    else
      flash[:notice] = I18n.t("flash_notice.transaction.transaction_completed_failed")
    end
    redirect_to @transaction
  end


  # Pay for a transaction when current user if the student and the transaction
  # state is "payment_pending"
  # Once the payment has been completed, the transaction state will be updated
  # See payment_controller.rb
  def pay
    set_transaction_and_role
    if @self != @transaction.student
      flash[:notice] = I18n.t("flash_notice.transaction.pay_invalid_role")
      redirect_to @transaction
      return
    end
    if @transaction.status != "payment_pending"
      flash[:notice] = I18n.t("flash_notice.transaction.cannot_pay")
      redirect_to @transaction
      return
    end
    payment = @transaction.build_payment
    if payment.save
      redirect_to payment
      return
    end
    flash[:notice] = I18n.t("flash_notice.transaction.payment_create_failed")
    redirect_to @transaction
  end

  def alipay
    puts "================================"
    puts "got response from alipay!!!!"
    puts "params:::#{params}"
    puts "================================"
    render status: 200
  end

  def destroy
    # not implemented yet
  end

  private

  def transaction_params
    params.require(:consult_transaction).permit(:instructor_id,
    :student_id,
    :privacy_policy,
    :hourly_price,
    :status,
    :rating,
    :service,
    :scheduled_date,
    :feed_back)
  end

  def set_transaction_and_role
    @transaction = ConsultTransaction.find_by_id(params[:id])
    not_found if @transaction.nil?
    if @transaction.student_id == current_user.id
      @self = @transaction.student
      @other = @transaction.instructor
      # @other = @transaction.student
    elsif @transaction.instructor_id == current_user.id
      @self = @transaction.instructor
      @other = @transaction.student
    else
      raise ApplicationController::NotAuthorized
    end
  end

  def generate_ali_pay_url transaction

    app_url = Rails.application.secrets.alipay[:api_url]
    app_id = Rails.application.secrets.alipay[:app_id]
    app_private_key = Rails.application.secrets.alipay[:app_private_key]
    alipay_public_key = Rails.application.secrets.alipay[:alipay_public_key]

    alipay_client = Alipay::Client.new(
      url: app_url,
      app_id: app_id,
      app_private_key: app_private_key,
      alipay_public_key: alipay_public_key
    )

    alipay_client.page_execute_url(
      method: 'alipay.trade.page.pay',
      return_url: payment_success_url(transaction),
      notify_url: alipay_callback_url(transaction),
      biz_content: {
        out_trade_no: "transaction-#{transaction.id}",
        product_code: 'FAST_INSTANT_TRADE_PAY',
        total_amount: transaction.payment_amount, #transaction.payment_amount, #1
        subject: "Payment for transaction #{transaction.id}"
      }.to_json # to_json is important!
      # timestamp: Time.now
    )

  end

  def request_aborted?
    params[:commit] == I18n.t("chat.decline")
  end

  def invalid_payment_amount?
    params[:consult_transaction][:hourly_price] == ""
  end
end
