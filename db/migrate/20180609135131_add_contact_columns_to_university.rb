class AddContactColumnsToUniversity < ActiveRecord::Migration[5.1]
  def change
    add_column :universities, :phone, :string
    add_column :universities, :fax, :string
    add_column :universities, :email, :string
    add_column :universities, :web_link, :string
    add_column :universities, :address1, :string
    add_column :universities, :address2, :string
    add_column :universities, :zipcode, :string
    add_column :universities, :city, :string
    add_column :universities, :state, :string
    # add_column :universities, :documents_required, :text
  end
end
