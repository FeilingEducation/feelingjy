class AddUserWalletScript < ActiveRecord::Migration[5.1]
  def change
    User.find_each do |user|
      UserWallet.create(user_id: user.id)
    end
  end
end
