class AddStdCountToInstructorInfo < ActiveRecord::Migration[5.1]
  def change
    add_column :instructor_infos, :max_std_count, :integer
    add_column :instructor_infos, :tutor_before, :integer
  end
end
