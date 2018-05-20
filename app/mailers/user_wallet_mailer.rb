class UserWalletMailer < ApplicationMailer

	def notify_yuting user_wallet_activity_id
    @user_wallet_activity = UserWalletActivity.find user_wallet_activity_id
    @current_user = User.find @user_wallet_activity.user_wallet.user_id
    mail( :to => 'liushengyu13579@gmail.com', :subject => 'A New withdrawal request is submitted' )
		# mail( :to => 'nadeem.yasin61@gmail.com', :subject => 'A New withdrawal request is submitted' )
	end

end
