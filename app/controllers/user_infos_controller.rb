class UserInfosController < AuthenticatedResourcesController

  skip_before_action :authenticate_user!, only: [:show]
  before_action :check_user_info_initialized

  def show
    @user_info = UserInfo.find(params.permit(:id))
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

  def user_info_params
    params.require(:user_info).permit(:avatar, :avatar_cache, :first_name,
    :last_name, :gender, :current_city, :home_town, :current_institute,
    :highest_education, :major, :other_majors, :years_in_program)
  end

end
