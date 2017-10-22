class AddPriceTypeToInstructorInfo < ActiveRecord::Migration[5.1]
  def change
    add_column :instructor_infos, :recommended_price, :boolean, default: true
  end
end
