module MessageHelper
  def message_class message
    message.receiver_id == current_user.id ? 'received-message reply-by-user' : 'sent-message msg-by-user'
  end
end
