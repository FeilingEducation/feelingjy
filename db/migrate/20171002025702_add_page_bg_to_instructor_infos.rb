class AddPageBgToInstructorInfos < ActiveRecord::Migration[5.1]
  def change
    add_column :instructor_infos, :page_background, :string
  end
end
