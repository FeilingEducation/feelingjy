class ChatLine < ApplicationRecord
  belongs_to :chat
  belongs_to :user_info
  after_create :touch_chat

  validates_presence_of :chat_id

  validate unless: lambda { |line| line.chat_id.nil? } do |line|
    transaction = line.chat.consult_transaction
    unless transaction.student_id == line.user_info_id || transaction.instructor_id == line.user_info_id
      errors.add(:base, "You are not a participant of this chat")
    end
  end

  protected

  def touch_chat
    self.chat.touch
  end
end
