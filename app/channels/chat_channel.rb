class ChatChannel < ApplicationCable::Channel
  # Called when the consumer has successfully
  # become a subscriber of this channel.
  def subscribed
    @chat = Chat.find_by(id: params[:chat_id])
    if @chat.nil?
      reject
    end
    transaction = @chat.consult_transaction
    if transaction.student_id != current_user.id && transaction.instructor_id != current_user.# IDEA:
      reject
    end
    stream_for @chat
  end
end
