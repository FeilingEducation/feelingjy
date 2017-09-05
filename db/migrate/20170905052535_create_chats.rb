class CreateChats < ActiveRecord::Migration[5.1]
  def change
    create_table :chats do |t|
      t.integer :consult_transaction_id, null: false, index: true
      t.timestamps
    end
  end
end
