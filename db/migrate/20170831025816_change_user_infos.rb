class ChangeUserInfos < ActiveRecord::Migration[5.1]
  def change
    rename_column :user_infos, :city, :current_city
    remove_column :user_infos, :about, :string, null: false, default: ''
    add_column :user_infos, :home_town, :string, null: false, default: ''
    add_column :user_infos, :current_institute, :string, null: false, default: ''
    add_column :user_infos, :highest_education, :string, null: false, default: ''
    add_column :user_infos, :major, :string, null: false, default: ''
    add_column :user_infos, :other_majors, :string, null: false, default: ''
    # with 0="graduated", and nil="not known"
    add_column :user_infos, :years_in_program, :integer
  end
end
