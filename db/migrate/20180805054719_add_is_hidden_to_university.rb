class AddIsHiddenToUniversity < ActiveRecord::Migration[5.1]
  def change
    add_column :universities, :is_hidden, :boolean, default: false
  end
end
