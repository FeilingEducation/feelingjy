class DebugController < ApplicationController

  before_action :restrict_to_development

  def index
    @user_infos = UserInfo.includes(:user)
  end

end
