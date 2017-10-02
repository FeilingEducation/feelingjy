class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  NotAuthorized = Class.new(StandardError)

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

  def restrict_to_development
    not_found unless Rails.env.development?
  end

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
end
