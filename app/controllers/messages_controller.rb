class MessagesController < AuthenticatedResourcesController

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
