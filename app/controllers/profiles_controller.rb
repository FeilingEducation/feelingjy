class ProfilesController < ApplicationController

  # render the same view as instructor_info/edit, but under the scope of
  # ProfileController. Therefore, ".editable" elements will not be shown.
  def show
    @instructor_info = InstructorInfo.find_by_id(params[:id])
    if @instructor_info.nil?
      not_found
    else
      @transaction = ConsultTransaction.new(instructor_id: @instructor_info.id)
    end
    render template: 'instructor_infos/edit'
  end
end
