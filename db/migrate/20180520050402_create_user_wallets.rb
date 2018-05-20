class CreateUserWallets < ActiveRecord::Migration[5.1]
  def change
    create_table :user_wallets do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :consult_transaction, foreign_key: true
      t.belongs_to :payment, foreign_key: true
      t.string :txn_type
      t.string :txn_status
      t.datetime :withdrawal_requested_at
      t.datetime :withdrawal_processed_at
      t.datetime :withdrawal_completed_at
      t.text :withdrawal_information

      t.timestamps
    end
  end
end
