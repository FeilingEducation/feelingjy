class CreatePrograms < ActiveRecord::Migration[5.1]
  def change
    create_table :programs do |t|
      t.belongs_to :department, foreign_key: true
      t.string :name_en
      t.string :name_cn
      t.string :degree
      t.string :website
      t.string :adminssion
      t.string :fall_deadline
      t.string :fall_deadline_round1
      t.string :fall_deadline_round2
      t.string :spring_deadline
      t.text :addmission_requirements
      t.text :contact
      t.string :tution
      t.text :note_en
      t.text :note_cn

      t.timestamps
    end
  end
end
