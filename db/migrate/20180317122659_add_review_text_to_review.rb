class AddReviewTextToReview < ActiveRecord::Migration[5.1]
  def change
    add_column :reviews, :review_text, :text
    add_column :reviews, :consult_transaction_id, :integer
    remove_column :reviews,  :service_communication
    remove_column :reviews,  :attitude
    remove_column :reviews,  :efficiency
    remove_column :reviews,  :authenticity
    remove_column :reviews,  :cost_effectiveness
  end
end
