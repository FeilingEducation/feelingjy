class Users::ProfilesController < ApplicationController
  def show
    if !UserInfo.exists?(params[:id])
      if user_signed_in? && current_user.id.to_s == params[:id]
        flash[:notice] = "Page will be available after filling in your information."
        return redirect_to(user_info_path)
      end
      not_found
    end
    @user_info = UserInfo.find(params[:id])
  end
end
