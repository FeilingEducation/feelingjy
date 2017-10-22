class AddUniversityInfoToInstructorInfo < ActiveRecord::Migration[5.1]
  def change
    add_column :instructor_infos, :university, :string
    add_column :instructor_infos, :specialization, :string
    add_column :instructor_infos, :degree_completed, :string
  end
end
