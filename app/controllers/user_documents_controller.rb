class UserDocumentsController < AuthenticatedResourcesController

  def create
    @doc = UserDocument.new(user_document_params)
    @doc.user_info_id = current_user.id
    if @doc.save
      flash[:notice] = 'File created successfully.'
    end
    redirect_to request.referer
  end

  def destroy
    @doc = UserDocument.find_by_id(params[:id])
    if @doc.user_info_id != current_user.id
      flash[:notice] = 'Unauthorized operation.'
    else
      @doc.remove_file!
      @doc.destroy
      flash[:notice] = 'File removed successfully.'
    end
    redirect_to request.referer
  end

  private

  def user_document_params
    params.require(:user_document).permit(
    :doc_type,
    :file
    )
  end
end
