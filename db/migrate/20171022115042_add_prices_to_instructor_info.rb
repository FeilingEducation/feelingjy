class AddPricesToInstructorInfo < ActiveRecord::Migration[5.1]
  def change
    add_column :instructor_infos, :min_price, :integer
    add_column :instructor_infos, :max_price, :integer
    add_column :instructor_infos, :fix_price, :integer
    add_column :instructor_infos, :work_frequency, :string
  end
end
