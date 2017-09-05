class CreateChatLines < ActiveRecord::Migration[5.1]
  def change
    create_table :chat_lines do |t|
      t.integer :chat_id, null: false, index: true
      t.text :content
      t.integer :user_info_id, null: false, index: true
      t.timestamps
    end
  end
end
