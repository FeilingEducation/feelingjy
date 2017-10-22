class AddAccurateTimeToInstructorInfo < ActiveRecord::Migration[5.1]
  def change
    add_column :instructor_infos, :ensure_accurate_time, :boolean
  end
end
