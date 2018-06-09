class AddUudiToDepartment < ActiveRecord::Migration[5.1]
  def change
    add_column :departments, :uuid, :string
  end
end
