class CreateAdminUser < ActiveRecord::Migration[5.1]
  def change
    AdminUser.create!(email: 'admin@feelingjy.com', password: '!32AdCDEep$$%#AADfij0909034ASSSCd#@@ASss!!!!casfasdfpjjjnnCCCSSSCDDD', password_confirmation: '!32AdCDEep$$%#AADfij0909034ASSSCd#@@ASss!!!!casfasdfpjjjnnCCCSSSCDDD')
  end
end
