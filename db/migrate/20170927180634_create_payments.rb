class CreatePayments < ActiveRecord::Migration[5.1]
  def change
    create_table :payments do |t|
      t.references :payable, polymorphic: true, index: true
      t.integer :method
      t.string :external_id
      t.integer :status
      t.timestamps
    end
  end
end
