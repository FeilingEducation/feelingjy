class Users::ProfilesController < ApplicationController
  def show
    if !UserInfo.exists?(params[:id])
      not_found
    end
    @user_info = UserInfo.find(params[:id])
  end
end
