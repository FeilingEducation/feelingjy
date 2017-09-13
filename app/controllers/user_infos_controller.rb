class UserInfosController < AuthenticatedResourcesController

  before_action :check_user_info_initialized

  def show
    @user_info = UserInfo.find(current_user.id)
  end

  def new
    @user_info = UserInfo.new
  end

  def create
    @user_info = UserInfo.new(user_info_params)
    @user_info.id = current_user.id
    respond_to do |format|
      if @user_info.save
        format.json
        format.html {
          flash[:notice] = "Profile created successfully."
          redirect_to(user_info_path)
        }
      else
        format.json { render json: { error: @user_info.errors.full_messages }, status: 422 }
        format.html { render('new') }
      end
    end
  end

  def edit
    @user_info = UserInfo.find(current_user.id)
  end

  def update
    @user_info = UserInfo.find(current_user.id)
    respond_to do |format|
      if @user_info.update_attributes(user_info_params)
        format.json { return }
        flash[:notice] = "Profile updated successfully."
      end
      format.json { render json: { error: @user_info.errors.full_messages }, status: 422 }
      format.html { render('edit') }
    end
  end

  private

  def user_info_params
    params.require(:user_info).permit(:avatar, :avatar_cache, :first_name,
    :last_name, :gender, :current_city, :home_town, :current_institute,
    :highest_education, :major, :other_majors, :program_year, :statement)
  end

end
