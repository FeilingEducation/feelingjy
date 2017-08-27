class AccountController < ApplicationController

  before_action :check_logged_out
  before_action :authenticate_user!

  def index
  end

  private

  def check_logged_out
    puts "checking logged out: #{user_signed_in?}, #{params[:logged_out] == 1}"
    if !user_signed_in? && params[:logged_out] == "1"
      redirect_to root_path
    end
  end
end
