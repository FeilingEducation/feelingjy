class AddOpenTokSessionIdToConsultTransaction < ActiveRecord::Migration[5.1]
  def change
    add_column :consult_transactions, :open_tok_session_id, :string
  end
end
