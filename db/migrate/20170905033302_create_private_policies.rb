class CreatePrivatePolicies < ActiveRecord::Migration[5.1]
  def change
    create_table :private_policies do |t|
      t.integer :instructor_id, null: false, index: true
      t.text :content
      t.boolean :pending, null: false, default: true

      t.timestamps
    end
  end
end
