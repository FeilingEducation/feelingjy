class InstructorInfosController < AuthenticatedResourcesController

  before_action :check_user_info_initialized
  before_action :check_instructor_info_initialized

  # Notice that there is no index or show action for this controller.
  # Those are handled by the user_info controller depending on if the current_user
  # is an instructor.

  def new
    @instructor_info = InstructorInfo.new
  end

  def create
    @instructor_info = InstructorInfo.new(instructor_info_params)
    @instructor_info.id = current_user.id
    if @instructor_info.save
      flash[:notice] = 'Instructor profile created successfully.'
      redirect_to(profile_path)
    else
      falsh[:notice] = 'Failed to create instructor info.'
      render('new')
    end
  end

  def edit
    @instructor_info = InstructorInfo.find_by_id(current_user.id)
    if @instructor_info.nil?
      flash[:notice] = 'You are not an instructor.'
      redirect_to '/search'
    end
  end

  def update
    @instructor_info = InstructorInfo.find(current_user.id)
    if @instructor_info.update_attributes(instructor_info_params)
      flash[:notice] = 'Instructor profile updated successfully'
    end
    redirect_to request.referer || edit_instructor_info_path
  end

  def destroy
    InstructorInfo.destroy(current_user.id)
    flash[:notice] = 'Instructor account closed successfully'
    redirect_to(user_info_path)
  end

  private

  def instructor_info_params
    params.require(:instructor_info).permit(:consult_experience,
    :previous_applications,
    :previous_offers,
    :gpa,
    :gre_score,
    :suggestions_to_students,
    :specialties,
    :available_time_slots,
    :busy_events,
    :is_early_consult,
    :is_brainstorm_consult,
    :is_essay_consult,
    :is_visa_consult,
    :consult_capacity_min,
    :consult_capacity_max,
    :consult_term_min,
    :consult_term_max,
    :consult_duration_min,
    :consult_duration_max,
    :consult_reserve_earliest,
    :consult_reserve_latest,
    :consult_frequency,
    :privacy_policy_template,
    :pricing_strategy,
    :price_min,
    :price_max,
    :price_base,
    :page_title,
    :page_background,
    :about_me,
    :url_linked_in)
  end
end
