class ChatChannel < ApplicationCable::Channel
  # Called when the consumer has successfully
  # become a subscriber of this channel.
  def subscribed
    @chat = Chat.find_by(id: params[:chat_id])
    reject if @chat.nil?
    transaction = @chat.consult_transaction
    reject if transaction.student_id != current_user.id && transaction.instructor_id != current_user.id
    stream_for @chat
  end
end
