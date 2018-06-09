class AddContactColumnsToDepartment < ActiveRecord::Migration[5.1]
  def change
    add_column :departments, :phone, :string
    add_column :departments, :fax, :string
    add_column :departments, :email, :string
    add_column :departments, :web_link, :string
    add_column :departments, :address1, :string
    add_column :departments, :address2, :string
    add_column :departments, :zipcode, :string
    add_column :departments, :city, :string
    add_column :departments, :state, :string
    add_column :departments, :documents_required, :text
  end
end
