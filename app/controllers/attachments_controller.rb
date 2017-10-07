class AttachmentsController < AuthenticatedResourcesController

  def create
    @doc = current_user.user_info.attachments.build(attachment_params)
    if @doc.save
      respond_to do |format|
        format.html {
          flash[:notice] = 'File created successfully.'
          redirect_to request.referer
        }
        format.json {
          render json: {files: [jq_upload_of(@doc)]}.to_json
        }
      end
    end
  end

  def destroy
    @doc = Attachment.find_by_id(params[:id])
    if !@doc.nil? && @doc.attachable.authorized_by(current_user)
      @doc.remove_file!
      @doc.destroy
      respond_to do |format|
        format.html {
          flash[:notice] = 'File removed successfully.'
          redirect_to request.referer
        }
        format.json {
          render json: {files: [jq_remove_of(@doc)]}.to_json
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
