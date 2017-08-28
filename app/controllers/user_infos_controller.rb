class UserInfosController < ApplicationController

  before_action :check_logged_out
  before_action :authenticate_user!
  before_action :check_initialized

  def show
    @user_info = UserInfo.find(current_user.id)
  end

  def new
    @user_info = UserInfo.new
  end

  def create
    @user_info = UserInfo.new(user_info_params)
    @user_info.id = current_user.id
    if @user_info.save
      flash[:notice] = "Profile created successfully."
      redirect_to(user_info_path)
    else
      render('new')
    end
  end

  def edit
    @user_info = UserInfo.find(current_user.id)
  end

  def update
    @user_info = UserInfo.find(current_user.id)
    if @user_info.update_attributes(user_info_params)
      flash[:notice] = "Profile updated successfully."
    end
    render('edit')
  end

  private

  def check_initialized
    if UserInfo.exists?(current_user.id)
      if action_name == 'new'
        redirect_to(user_info_path)
      end
    elsif %w(show edit).include?(action_name)
      flash[:notice] = "Page will be available after filling in your information."
      redirect_to(new_user_info_path)
    end
  end

  def user_info_params
    params.require(:user_info).permit(:first_name, :last_name, :gender, :city, :about)
  end

  def check_logged_out
    if !user_signed_in? && params[:logged_out] == "1"
      redirect_to root_path
    end
  end

end
