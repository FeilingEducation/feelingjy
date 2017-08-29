class AddAvatarToUserInfos < ActiveRecord::Migration[5.1]
  def change
    add_column :user_infos, :avatar, :string
  end
end
