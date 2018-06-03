class AddDescriptionEnAnddescriptionCnToUniversity < ActiveRecord::Migration[5.1]
  def change
    add_column :universities, :description_en, :text
    add_column :universities, :description_cn, :text
    remove_column :universities, :description
    remove_column :universities, :logo_name
  end
end
