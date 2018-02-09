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
      flash[:notice] = 'Transaction saved successfully.'
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
    @payment_amount = @transaction.payment_amount
  end

  def update
    set_transaction_and_role
    if @transaction.update_attributes(transaction_params)
      flash[:notice] = 'Transaction updated successfully.'
      redirect_to(consult_transaction_path)
    else
      render('show')
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
          flash[:notice] = 'Transaction confirmed. Waiting for student payment.'
        else
          flash[:notice] = 'Failed to confirm transaction. Please try again later'
        end
      elsif params.permit(:cancel)
        if @transaction.update(status: :initiated)
          flash[:notice] = 'Transaction confirmation canceled.'
        else
          flash[:notice] = 'Failed to cancel confirmation. Please try again later'
        end
      else
        flash[:notice] = 'Cannot confirm transaction at the current status.'
      end
    else
      flash[:notice] = 'Invalid operation.'
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
      flash[:notice] = 'Invalid role'
      redirect_to @transaction
      return
    end
    if @transaction.status != "payment_pending"
      flash[:notice] = 'Cannot pay at current status'
      redirect_to @transaction
      return
    end
    payment = @transaction.build_payment
    if payment.save
      redirect_to payment
      return
    end
    flash[:notice] = 'Cannot create payment. Please try again later.'
    redirect_to @transaction
  end

  def alipay
    puts "================================"
    puts "got response from alipay!!!!"
    puts "params:::#{params}"
    puts "================================"
    render status: 200
  end

  def alipay_callback
    puts "got response from alipay_callback!!!!"
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
      return_url: consult_transaction_url(transaction),
      notify_url: alipay_callback_url(transaction)
      biz_content: {
        out_trade_no: "transaction-#{transaction.id}",
        product_code: 'FAST_INSTANT_TRADE_PAY',
        total_amount: 1, #transaction.payment_amount,
        subject: "Payment for transaction #{transaction.id}"
      }.to_json # to_json is important!
      # timestamp: Time.now
    )

  end

end
