class AddLinkedinToInstructorInfos < ActiveRecord::Migration[5.1]
  def change
    add_column :instructor_infos, :url_linked_in, :string
  end
end
