class AddDiscountForFirstStudentToInstructorInfo < ActiveRecord::Migration[5.1]
  def change
    add_column :instructor_infos, :first_std_discount, :boolean, default: true
  end
end
