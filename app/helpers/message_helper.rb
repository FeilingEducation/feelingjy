module MessageHelper
  def message_class message
    message.receiver_id == current_user.id ? 'received-message' : 'sent-message'
  end
end
