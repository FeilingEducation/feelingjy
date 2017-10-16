class MessagesController < AuthenticatedResourcesController

  def index
    @user_info = current_user.user_info
    received = Message.where(receiver_id: current_user.id)
    sent_contacts = received.group_by {|m| m.sender}
    sent = Message.where(sender_id: current_user.id)
    received_contacts = sent.group_by {|m| m.receiver}
    @grouped_msgs = sent_contacts
    for contact, msgs in received_contacts do
      if @grouped_msgs.key?(contact)
        @grouped_msgs[contact] += msgs
      else
        @grouped_msgs[contact] = msgs
      end
      @grouped_msgs[contact].sort_by! {|m| m.created_at}
    end
    @contacts = @grouped_msgs.keys.sort_by {|c| @grouped_msgs[c][-1].created_at}.reverse
  end

  # Create a message and associate all attachments with itself.
  # Attachments are uploaded associated only with the user. Once the message is
  # created, all attachments identified by the attachments_id[] field will have
  # their "attachable" field changed from a user_info model to this message.
  #
  # TODO: use ActiveRecord.transaction to avoid intermediate state at failure
  def create
    msg = Message.new(message_params)
    msg.sender_id = current_user.id
    if msg.save
      attachments = []
      attachment_ids = params.permit(attachment_ids: [])[:attachment_ids] || []
      for attachment_id in attachment_ids
        attachment = Attachment.find_by_id(attachment_id)
        if attachment
          if attachment.attachable.authorized_by(current_user)
            unless attachment.update_attributes(attachable: msg)
              logger.warn "Failed to update attachment: #{attachment_id}"
            else
              # for JSON respond
              attachments << { name: attachment.read_attribute(:file), url: attachment.file.url }
            end
          else
            logger.warn "Unauthorized operation"
          end
        else
          logger.warn "Cannot find attachment: #{attachment_id}"
        end
      end
      respond_to do |format|
        format.json {
          render json: {
            timestamp: msg.created_at.strftime('%b %-d, %y - %l:%M %p'),
            sender: msg.sender.full_name,
            receiver: msg.receiver.full_name,
            content: msg.content,
            attachments: attachments
          }
        }
      end
    else
      logger.warn "Cannot save message: #{msg.full_messages}"
    end
  end

  private

  def message_params
    params.require(:message).permit(:receiver_id, :content)
  end
end
