class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.text :service_communication
      t.text :attitude
      t.text :efficiency
      t.text :authenticity
      t.text :cost_effectiveness
      t.integer :service_communication_rating
      t.integer :attitude_rating
      t.integer :efficiency_rating
      t.integer :authenticity_rating
      t.integer :cost_effectiveness_rating
      t.integer :user_id
      t.integer :reviewer_id

      t.timestamps
    end
  end
end
