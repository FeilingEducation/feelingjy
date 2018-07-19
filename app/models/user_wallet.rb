class UserWallet < ApplicationRecord

  # UserWallet
  # - user_id
  # - amount

  belongs_to :user
  has_many :user_wallet_activities, dependent: :destroy

  accepts_nested_attributes_for :user_wallet_activities

  def total_withdrawl
    user_wallet_activities.where(txn_status: :withdrawal_completed).sum(:amount) || 0
  end

  def total_earned
    user_wallet_activities.where(txn_type: :credit).sum(:amount) || 0
  end

  def total_pending
    user_wallet_activities.where("txn_status IN (?)", [1,2]).sum(:amount) || 0
  end

  def total_balance
    user_wallet_activities.where("txn_type =? and txn_status is null", 2).sum(:amount) || 0
  end

end
