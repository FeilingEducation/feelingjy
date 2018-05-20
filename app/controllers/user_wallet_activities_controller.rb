class UserWalletActivitiesController < ApplicationController

  def create
    @user_wallet_activity = UserWalletActivity.new user_wallet_activity_params
    @user_wallet_activity.user_wallet = current_user.user_wallet
    if @user_wallet_activity.save
      UserWalletMailer.notify_yuting @user_wallet_activity.id
      flash[:notice] = "Your withdrawal request has been submitted successfully"
    else
      flash[:error] = "There was some error in your request. Please contact support"
    end
    redirect_to user_wallets_path
  end

  private
    def user_wallet_activity_params
      params.require(:user_wallet_activity).permit(:amount)
    end
end
