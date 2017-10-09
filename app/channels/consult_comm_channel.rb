class ConsultCommChannel < ApplicationCable::Channel
  # Called when the consumer has successfully
  # become a subscriber of this channel.
  def subscribed
    # ensure the transaction exists, and the current is either the student or the instructor
    @transaction = ConsultTransaction.find_by_id(params[:transaction_id])
    reject if @transaction.nil?
    if @transaction.student_id == current_user.id
      @other = User.find(@transaction.instructor.id)
    elsif @transaction.instructor_id == current_user.id
      @other = User.find(@transaction.student_id)
    else
      reject
    end
    stream_for @transaction
    # also subscribe by the current_user object so one user can send direct message
    # to the other without broadcasting it
    stream_for current_user
  end

  def create_chat_line(data)
    # don't write empty chat-line to DB
    if data['content'].empty?
      transmit type: 'chat_line', comm_data: nil
      return
    end
    chat_line = ChatLine.new(content: data['content'], user_info_id: current_user.id, chat_id: @transaction.chat.id)
    if chat_line.save
      ConsultCommChannel.broadcast_to @transaction, type: 'chat_line', comm_data: {content: data['content'], user_id: current_user.id}
    else
      transmit type: 'error', comm_data: {content: 'Failed to save chat line.'}
    end
  end

  def setup_voice_chat(data)
    # send voice chat metadata to the other user
    ConsultCommChannel.broadcast_to @other, type: 'voice_chat', comm_data: data.slice("type", "payload")
  end
end
