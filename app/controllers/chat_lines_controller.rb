class ChatLinesController < AuthenticatedResourcesController

  def create
    chat_line = ChatLine.new(chat_line_params)
    chat_line.user_info_id = current_user.id
    if chat_line.save
      ChatChannel.broadcast_to chat_line.chat, content: chat_line.content, user_info_id: chat_line.user_info_id
      head :ok
    else
      puts "************* failed to save chat_line: #{chat_line.errors.full_messages}"
    end
  end

  private

  def chat_line_params
    params.require(:chat_line).permit(
      :chat_id,
      :content
    )
  end
end
