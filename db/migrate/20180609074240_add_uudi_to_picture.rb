class AddUudiToPicture < ActiveRecord::Migration[5.1]
  def change
    add_column :pictures, :uuid, :string
  end
end
