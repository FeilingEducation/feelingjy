class AuthenticatedResourcesController < ApplicationController
  before_action :check_logged_out
  before_action :authenticate_user!

  private

  def check_logged_out
    if !user_signed_in? && params[:logged_out] == "1"
      redirect_to root_path
    end
  end

end
