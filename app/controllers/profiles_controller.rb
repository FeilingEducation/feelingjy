class ProfilesController < ApplicationController

  def show
    @instructor_info = InstructorInfo.find_by_id(params[:id])
    if @instructor_info.nil?
      not_found
    else
      @transaction = ConsultTransaction.new(instructor_id: @instructor_info.id)
    end
  end
end
