class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def not_found
    raise ActionController::RoutingError.new('Not Found')
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

end
