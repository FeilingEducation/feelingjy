class Users::Security::ConfirmationsController < Devise::ConfirmationsController
  private
  def after_confirmation_path_for(resource_name, resource)
    root_path(notice: "Please confirm your email.")
  end
end
