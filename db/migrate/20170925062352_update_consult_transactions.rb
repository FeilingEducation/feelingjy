class UpdateConsultTransactions < ActiveRecord::Migration[5.1]
  def change
    add_column :consult_transactions, :service, :string
  end
end
