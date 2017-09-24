class ProfilesController < ApplicationController
  def show
    unless InstructorInfo.exists?(params[:id])
      not_found
    else
      @instructor = InstructorInfo.find(params[:id])
      @transaction = ConsultTransaction.new
    end
  end
end
