class UserWalletActivity < ApplicationRecord

  # UserWalletActivity
  # - consult_transaction_id
  # - payment_id
  # - txn_type [:debit, :credit]
  # - txn_status [:withdrawal_requested, :withdrawal_processing, :withdrawal_completed]
  # - withdrawal_requested_at [:timestamp]
  # - withdrawal_processed_at [:timestamp]
  # - withdrawal_completed_at [:timestamp]
  # - withdrawal_information [:any bank information. Manually entered via super admin panel]
  # - created_at
  # - updated_at
  # - amount

  belongs_to :user_wallet
  # belongs_to :consult_transaction
  # belongs_to :payment

  enum txn_type: {
    debit: 1,
    credit: 2
  }

  enum txn_status: {
    withdrawal_requested: 1,
    withdrawal_processing: 2,
    withdrawal_completed: 3
  }
end
