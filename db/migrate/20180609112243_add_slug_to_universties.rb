class AddSlugToUniversties < ActiveRecord::Migration[5.1]
  def change
    add_column :universities, :slug, :string
  end
end
