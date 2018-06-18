class AddColsToDepartment < ActiveRecord::Migration[5.1]
  def change
    add_column :departments, :website, :string
    add_column :departments, :address, :text
    add_column :departments, :contact, :text
    add_column :departments, :program_list, :string
    add_column :departments, :tofel_code, :string
    add_column :departments, :gre_code, :string
    add_column :departments, :gmat_code, :string
  end
end
