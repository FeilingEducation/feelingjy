class AddHelpedOthersToInstructorInfo < ActiveRecord::Migration[5.1]
  def change
    add_column :instructor_infos, :helped_before, :boolean
  end
end
