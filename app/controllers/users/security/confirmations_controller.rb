class Users::Security::ConfirmationsController < Devise::ConfirmationsController
  private
  def after_confirmation_path_for(resource_name, resource)
    confirmation_success_path
  end
end
