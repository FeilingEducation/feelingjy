class AddUudiToUniversity < ActiveRecord::Migration[5.1]
  def change
    add_column :universities, :uuid, :string
  end
end
