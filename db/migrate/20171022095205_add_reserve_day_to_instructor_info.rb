class AddReserveDayToInstructorInfo < ActiveRecord::Migration[5.1]
  def change
    add_column :instructor_infos, :reserve_advance, :integer
  end
end
