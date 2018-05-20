class UserWalletsController < ApplicationController

  def index
    @user_wallet = current_user.user_wallet
    @user_debit_activities = @user_wallet.user_wallet_activities.where(txn_type: :debit)
    @user_credit_activities = @user_wallet.user_wallet_activities.where(txn_type: :credit)
    @user_wallet_activity = UserWalletActivity.new(user_wallet_id: @user_wallet.id)
  end

  def create
  end

end
