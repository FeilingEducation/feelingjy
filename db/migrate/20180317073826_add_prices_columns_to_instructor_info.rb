class AddPricesColumnsToInstructorInfo < ActiveRecord::Migration[5.1]
  def change
    add_column :instructor_infos, :consult_min_price, :integer
    add_column :instructor_infos, :consult_max_price, :integer
    add_column :instructor_infos, :consult_fix_price, :integer
    add_column :instructor_infos, :brainstorm_min_price, :integer
    add_column :instructor_infos, :brainstorm_max_price, :integer
    add_column :instructor_infos, :brainstorm_fix_price, :integer
    add_column :instructor_infos, :essay_min_price, :integer
    add_column :instructor_infos, :essay_max_price, :integer
    add_column :instructor_infos, :essay_fix_price, :integer
    add_column :instructor_infos, :visa_min_price, :integer
    add_column :instructor_infos, :visa_max_price, :integer
    add_column :instructor_infos, :visa_fix_price, :integer
  end
end
