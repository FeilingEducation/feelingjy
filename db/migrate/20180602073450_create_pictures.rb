class CreatePictures < ActiveRecord::Migration[5.1]
  def change
    create_table :pictures do |t|
      t.references :pictureable, polymorphic: true
      # t.attachment :image

      t.timestamps
    end
  end
end
