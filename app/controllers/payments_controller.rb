class PaymentsController < ApplicationController

  def show
    @payment = Payment.find_by(params.permit(:id))
    @payment.completed!
    @payment.payable.payment_completed!
    flash[:notice] = 'Now all payments are automatically completed.'
    redirect_to @payment.payable
  end

  def update
  end

end
