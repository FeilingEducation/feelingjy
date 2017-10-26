class AddGoodAtApplyingForToInstructorInfo < ActiveRecord::Migration[5.1]
  def change
    add_column :instructor_infos, :best_applying_at, :integer
  end
end
