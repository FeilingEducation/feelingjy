class ModifyUserInfos < ActiveRecord::Migration[5.1]
  def change
    change_column_null :user_infos, :current_city, true, ""
    change_column_null :user_infos, :home_town, true, ""
    change_column_null :user_infos, :current_institute, true, ""
    change_column_null :user_infos, :highest_education, true, ""
    change_column_null :user_infos, :major, true, ""
    change_column_null :user_infos, :other_majors, true, ""
    change_column_default :user_infos, :first_name, from: '', to: nil
    change_column_default :user_infos, :last_name, from: '', to: nil
    change_column_default :user_infos, :gender, from: 0, to: nil
    change_column_default :user_infos, :current_city, from: '', to: nil
    change_column_default :user_infos, :home_town, from: '', to: nil
    change_column_default :user_infos, :current_institute, from: '', to: nil
    change_column_default :user_infos, :highest_education, from: '', to: nil
    change_column_default :user_infos, :major, from: '', to: nil
    change_column_default :user_infos, :other_majors, from: '', to: nil
  end
end
