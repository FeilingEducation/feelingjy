class CreateConsultTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :consult_transactions do |t|
      t.integer :instructor_id, null: false, index: true
      t.integer :student_id, null: false, index: true
      t.text :privacy_policy
      t.integer :hourly_price
      t.integer :status
      t.integer :rating
      t.text :feed_back
      # consult events as a relation
      t.timestamps
    end
  end
end
