class ConsultTransactionsController < AuthenticatedResourcesController
  def index
    @role = params.permit(:role)[:role]
    if !%w(student instructor).include? role
      @role = InstructorInfo.exists?(current_user.id) ? 'instructor' : 'student'
    end
    @transactions = ConsultTransaction.select(:"#{@role}_id" => current_user.id)
  end

  def new
    @transaction = ConsultTransaction.new
  end

  def create
    instructor = InstructorInfo.find(params.permit[:id])
    # TODO: put privacy_policy into db with versioning
    # TODO: what should we use for hourly_price?
    # TODO: check if instructor has been updated since 'new'
    @transaction = ConsultTransaction.new(
    student_id: current_user.id,
    instructor_id: instructor.id,
    privacy_policy: instructor.privacy_policy_template,
    hourly_price: instructor.price_base,
    status: 'initiated')
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
      redirect_to(consult_transaction_path())
    else
      render('show')
    end
  end

  def destroy
    # not implemented yet
  end

  private

  def transaction_params
    params.require(:consult_transaction).permit(:instructor_id,
    :privacy_policy,
    :hourly_price,
    :status,
    :rating,
    :feed_back)
  end

  def set_transaction_and_role
    @transaction = ConsultTransaction.find(params.permit(:id))
    if @transaction.student_id == current_user.id
      'student'
    elsif @transaction.instructor_id == current_user.id
      'instructor'
    else
      raise ApplicationController::NotAuthorized
    end
  end

end
