class CreateUniversities < ActiveRecord::Migration[5.1]
  def change
    create_table :universities do |t|
      t.string :name_en
      t.string :name_cn
      t.string :logo_name
      t.text :description

      t.timestamps
    end
  end
end
