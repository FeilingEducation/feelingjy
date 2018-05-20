class CreateUserWalletActivities < ActiveRecord::Migration[5.1]
  def change
    create_table :user_wallet_activities do |t|
      t.belongs_to :user_wallet, foreign_key: true
      t.belongs_to :consult_transaction, foreign_key: true
      t.belongs_to :payment, foreign_key: true
      t.integer :txn_type
      t.integer :txn_status
      t.datetime :withdrawal_requested_at
      t.datetime :withdrawal_processed_at
      t.datetime :withdrawal_completed_at
      t.text :withdrawal_information
      t.float :withdrawal_information

      t.timestamps
    end
  end
end
