class AddAdnvacnceDayToInstructorInfo < ActiveRecord::Migration[5.1]
  def change
    add_column :instructor_infos, :advance_notify, :integer
  end
end
