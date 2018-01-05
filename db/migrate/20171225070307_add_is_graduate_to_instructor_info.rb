class AddIsGraduateToInstructorInfo < ActiveRecord::Migration[5.1]
  def change
    add_column :instructor_infos, :is_graduate, :boolean, default: true
  end
end
