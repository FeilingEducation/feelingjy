class AddIsInstructorToUserInfos < ActiveRecord::Migration[5.1]
  def change
    add_column :user_infos, :is_instructor, :boolean, default: false, null: false
  end
end
