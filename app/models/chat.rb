class Chat < ApplicationRecord
  belongs_to :consult_transaction
  has_many :chat_lines

  after_destroy :destroy_chat_lines

  def destroy_chat_lines
    ChatLine.destroy(chat_id: self.id)
  end
end
