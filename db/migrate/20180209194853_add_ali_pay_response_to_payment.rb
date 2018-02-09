class AddAliPayResponseToPayment < ActiveRecord::Migration[5.1]
  def change
    add_column :payments, :alipay_response, :jsonb
  end
end
