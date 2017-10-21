class AddDescriptionToInstructorInfo < ActiveRecord::Migration[5.1]
  def change
    add_column :instructor_infos, :description, :text
  end
end
