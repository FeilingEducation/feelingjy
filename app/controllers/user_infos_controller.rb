class UserInfosController < AuthenticatedResourcesController
  # See /views/layouts/user_info.html.erb
  # A layout with basic user infomation on the left and a menu bar
  layout 'user_info', except: [:show_student, :show_instructor]
  before_action :check_user_info_initialized

  def show
    @user_info = UserInfo.find(current_user.id)
    @self = InstructorInfo.find_by_id(current_user.id)
    if @self.nil?
      @self = @user_info
      @other_role = 'instructor'
    else
      @other_role = 'student'
    end
  end

  def show_student
    @user_info = UserInfo.find(current_user.id)
  end

  def show_instructor
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
        format.js {
          flash.now[:notice] = "Profile updated successfully."
        }
        format.html {
          flash[:notice] = "Profile updated successfully."
        }
      else
        format.json { render json: { error: @user_info.errors.full_messages }, status: 422 }
        format.html { render('edit') }
      end
    end
    redirect_to request.referer || 'edit'
  end

  def messages
    @user_info = current_user.user_info
    @latest_messages = Message.where(receiver_id: current_user.id).order(created_at: :desc).limit(10)
  end

  private

  def user_info_params
    params.require(:user_info).permit(:avatar, :avatar_cache, :first_name,
    :last_name, :gender, :current_city, :home_town, :current_institute,
    :highest_education, :major, :other_majors, :program_year, :statement)
  end

  def instructor_info_params
    params.require(:instructor_info).permit(:url_linked_in)
  end

end
