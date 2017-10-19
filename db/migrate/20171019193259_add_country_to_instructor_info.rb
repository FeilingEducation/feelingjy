class AddCountryToInstructorInfo < ActiveRecord::Migration[5.1]
  def change
    add_column :instructor_infos, :country, :string
    add_column :instructor_infos, :state, :string
    add_column :instructor_infos, :city, :string
  end
end
