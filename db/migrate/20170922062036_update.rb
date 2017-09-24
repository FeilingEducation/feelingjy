class Update < ActiveRecord::Migration[5.1]
  def change
    add_column :chat_lines, :content, :text
    add_reference :chat_lines, :chat
    add_reference :chat_lines, :user_info
  end
end
