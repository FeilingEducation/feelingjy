class AddUniAcceptedToInstructorInfo < ActiveRecord::Migration[5.1]
  def change
    add_column :instructor_infos, :uni_accepted, :integer, array: true
  end
end
