class AddWorkDaysToInstructorInfo < ActiveRecord::Migration[5.1]
  def change
    add_column :instructor_infos, :min_work_days, :integer, default: 2
    add_column :instructor_infos, :max_work_days, :integer, default: 2
  end
end
