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
    @transactions = ConsultTransaction.where("#{@role}_id": current_user.id)
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
    elsif @transaction.instructor_id == current_user.id
      @self = @transaction.instructor
      @other = @transaction.student
    else
      raise ApplicationController::NotAuthorized
    end
  end

end
