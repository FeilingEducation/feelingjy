class AddUserInfoStatement < ActiveRecord::Migration[5.1]
  def change
    add_column :user_infos, :statement, :text
  end
end
