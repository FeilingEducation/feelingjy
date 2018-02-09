class PaymentsController < ApplicationController

  protect_from_forgery except: :alipay_callback

  # TODO: Currently payment is automatically completed.
  # TODO: Update transaction status when payment is completed.
  def show
    @payment = Payment.find_by(params.permit(:id))
    @payment.completed!
    @payment.payable.payment_completed!
    flash[:notice] = 'Now all payments are automatically completed.'
    redirect_to @payment.payable
  end

  def update
  end

  def alipay_callback
    puts "got response from alipay_callback!!!!"
    puts "params:::#{params}"
    puts "================================"
    transaction = ConsultTransaction.find_by_id params[:consult_tx_id]
    payment = transaction.build_payment
    payment.status = 3
    payment.alipay_response = params.to_json
    payment.save!

    # {"gmt_create"=>"2018-02-10 03:21:23",
    # "charset"=>"UTF-8",
    # "gmt_payment"=>"2018-02-10 03:21:38",
    # "notify_time"=>"2018-02-10 03:21:38",
    # "subject"=>"Payment for transaction 1",
    # "sign"=>"JJYZ/ocfRpUFgFMognFJVZwXq9GkhmE/i2FSRvr5UzgE8pH/uAWOCfqefxiQKQCHNn94GdfEtMPMslqsuS5GQ2xLjjBxovxIXfS36rSVK27W3s4Ge6dUWBQ5udZpSYW8FMvWT7b34xNGsY/EHOqUhSO/P66X2M2cFtbFfJmLkJglbBPO26obpwNAXBpA4RWYvABuIf9S9LQXDMuwQ03QSZF4HOjZkn8PROzgbB8r7JU4gFO9ZkEPrKpgHybOI3/K1OSGAHj0GTV+bn8R8gTcDvZ5p2hEPviPTIyHp4G3ligO+KyrXXcvXVhoH0+UcF+Ur3PJIAd4/iD7L0qmkMubkg==",
    # "buyer_id"=>"2088722311280673",
    # "invoice_amount"=>"1.00",
    # "version"=>"1.0",
    # "notify_id"=>"6a57891ae7f1e2fffc7266d4488ee12l69",
    # "fund_bill_list"=>"[{\"amount\":\"1.00\",\"fundChannel\":\"ALIPAYACCOUNT\"}]",
    # "notify_type"=>"trade_status_sync",
    # "out_trade_no"=>"transaction-1",
    # "total_amount"=>"1.00",
    # "trade_status"=>"TRADE_SUCCESS",
    # "trade_no"=>"2018021021001004670553021176",
    # "auth_app_id"=>"2017122801301031",
    # "receipt_amount"=>"1.00",
    # "point_amount"=>"0.00",
    # "app_id"=>"2017122801301031",
    # "buyer_pay_amount"=>"1.00",
    # "sign_type"=>"RSA2",
    # "seller_id"=>"2088921395591671",
    # "consult_tx_id"=>"1"}
    render status: 200
  end



end
