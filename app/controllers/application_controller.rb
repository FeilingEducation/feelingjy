class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale

  NotAuthorized = Class.new(StandardError)

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

  def restrict_to_development
    not_found unless Rails.env.development?
  end

  # use logged_out=1 query to distinguish unauthorized page access and log out
  # from privileged page: the first one goes to sign in page while the second
  # goes to home
  def after_sign_out_path_for(resource_or_scope)
    # path before sign out request
    "#{URI(request.referer).path}?logged_out=1"
  end

  def after_sign_in_path_for(resource_or_scope)
    # TODO: better way to detect sign up request; override maybe?
    if request.env['PATH_INFO'] == user_registration_path && request.method_symbol == :post
      # jump to account path when first registered
      user_info_path
    else
      stored_location_for(resource_or_scope) || signed_in_root_path(resource_or_scope)
    end
  end

  # no longer used as user_info will always created at registration.
  def check_user_info_initialized
    exists = UserInfo.exists?(current_user.id)
    create = controller_name == 'user_infos' && %w(new create).include?(action_name)
    if exists && create
      redirect_to(user_info_path)
    elsif !exists && !create
      flash[:notice] = "Page will be available after filling in your information."
      redirect_to(new_user_info_path)
    end
  end

  # if instructor_info not initialized and user tries to access instructor pages
  # other than create and new, go to new, vise versa.
  def check_instructor_info_initialized
    exists = InstructorInfo.exists?(current_user.id)
    create = controller_name == 'instructor_infos' && %w(new create).include?(action_name)
    if exists && create
      redirect_to(edit_instructor_info_path)
    elsif !exists && !create
      flash[:notice] = "Page will be available after filling in your information."
      redirect_to(new_instructor_info_path)
    end
  end

  private
    # Set Local for translation
    def set_locale
      I18n.locale = session[:locale] || I18n.default_locale
    end

end
