class Update < ActiveRecord::Migration[5.1]
  def change
    remove_column :chat_lines, :chat_id
    remove_column :chat_lines, :user_info_id
    add_reference :chat_lines, :chat
    add_reference :chat_lines, :user_info
  end
end
