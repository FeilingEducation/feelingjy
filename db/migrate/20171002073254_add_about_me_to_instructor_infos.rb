class AddAboutMeToInstructorInfos < ActiveRecord::Migration[5.1]
  def change
    add_column :instructor_infos, :about_me, :text
  end
end
