class ConsultTransactionScheduledDate < ActiveRecord::Migration[5.1]
  def change
    add_column :consult_transactions, :scheduled_date, :date
  end
end
