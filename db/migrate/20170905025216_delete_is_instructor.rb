class DeleteIsInstructor < ActiveRecord::Migration[5.1]
  def change
    remove_column :user_infos, :is_instructor, :boolean, default: false, null: false
  end
end
