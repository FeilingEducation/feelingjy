class AddMoreColsToUniversity < ActiveRecord::Migration[5.1]
  def change
    add_column :universities, :contact, :text
    add_column :universities, :address, :text
    add_column :universities, :grad_website, :string
    add_column :universities, :grad_contact, :string
    add_column :universities, :grad_address, :string
    add_column :universities, :program_list, :string
    add_column :universities, :overview, :string
    add_column :universities, :news_18, :text
    add_column :universities, :news_17, :text
  end
end
