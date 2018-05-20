class UserWalletsController < ApplicationController

  def index
    @user_wallet = current_user.user_wallet
    @user_wallet_activity = UserWalletActivity.new(user_wallet_id: @user_wallet.id)
  end

  def create
  end

end
