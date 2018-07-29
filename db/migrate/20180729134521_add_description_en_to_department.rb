class AddDescriptionEnToDepartment < ActiveRecord::Migration[5.1]
  def change
    add_column :departments, :description_en, :text
    add_column :departments, :description_cn, :text
  end
end
