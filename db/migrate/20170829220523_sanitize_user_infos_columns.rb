class SanitizeUserInfosColumns < ActiveRecord::Migration[5.1]
  def up
    change_column :user_infos, :first_name, :string, null: false, default: ''
    change_column :user_infos, :last_name, :string, null: false, default: ''
    remove_column :user_infos, :gender
    add_column :user_infos, :gender, :integer, null: false, default: 0
    change_column :user_infos, :city, :string, null: false, default: ''
    change_column :user_infos, :about, :string, null: false, default: ''
  end

  def down
    change_column :user_infos, :first_name, :string, null: true, default: nil
    change_column :user_infos, :last_name, :string, null: true, default: nil
    remove_column :user_infos, :gender
    add_column :user_infos, :gender, :string, null: true, default: nil
    change_column :user_infos, :city, :string, null: true, default: nil
    change_column :user_infos, :about, :string, null: true, default: nil
  end
end
