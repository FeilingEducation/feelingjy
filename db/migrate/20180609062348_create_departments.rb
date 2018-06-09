class CreateDepartments < ActiveRecord::Migration[5.1]
  def change
    create_table :departments do |t|
      t.string :name_en
      t.string :name_cn
      t.text :details_en
      t.text :details_cn
      t.datetime :submission_deadline
      t.integer :ranking
      t.belongs_to :university, foreign_key: true

      t.timestamps
    end
  end
end
