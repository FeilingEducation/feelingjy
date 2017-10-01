class UserDocumentsController < AuthenticatedResourcesController

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
end
