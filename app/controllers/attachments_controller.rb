class AttachmentsController < AuthenticatedResourcesController

  # TODO: do we need a way to show all attachments uploaded by the user?
  # TODO: do we need to periodically remove some attachment of the user, i.e.
  #       uploaded attachments that are never sent

  # creates an attachment
  def create
    attachment = current_user.user_info.attachments.build(attachment_params)
    if attachment.save
      respond_to do |format|
        format.html {
          flash[:notice] = 'File created successfully.'
          redirect_to request.referer
        }
        format.json {
          render json: {files: [jq_upload_of(attachment)]}.to_json
        }
      end
    end
  end

  # destroy an attachment
  def destroy
    attachment = Attachment.find_by_id(params[:id])
    # can only destroy if the current user owns the attachment
    if !attachment.nil? && attachment.attachable.authorized_by(current_user)
      attachment.remove_file!
      attachment.destroy
      respond_to do |format|
        format.html {
          flash[:notice] = 'File removed successfully.'
          redirect_to request.referer
        }
        format.json {
          render json: {files: [jq_remove_of(attachment)]}.to_json
        }
      end
    else
      flash[:notice] = 'Unauthorized operation.'
    end
  end

  private

  def attachment_params
    params.require(:attachment).permit(
    :file_type,
    :file
    )
  end

  # JSON respond to jquery ajax request
  # See /app/assets/javascripts/attachments.js
  def jq_upload_of(attachment)
    {
      name: attachment.read_attribute(:file),
      id: attachment.id,
      size: attachment.file.size,
      url: attachment.file.url,
      delete_url: attachment_path(attachment),
      delete_type: 'DELETE'
    }
  end

  def jq_remove_of(attachment)
    {
      "#{attachment.read_attribute(:file)}": true
    }
  end
end
