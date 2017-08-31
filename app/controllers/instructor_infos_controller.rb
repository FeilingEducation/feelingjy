class InstructorInfosController < ApplicationController

  before_action :check_logged_out
  before_action :authenticate_user!
  before_action :check_user_info_initialized
  before_action :check_instructor_info_initialized

  def new
    @instructor_info = InstructorInfo.new
  end

  def create
    @instructor_info = InstructorInfo.new(instructor_info_params)
    @instructor_info.id = current_user.id
    if @instructor_info.save
      user_info = UserInfo.find(current_user.id)
      user_info.is_instructor = true
      if user_info.save
        flash[:notice] = 'Instructor profile created successfully.'
        redirect_to(instructor_info_path)
        return
      else
        @instructor_info.destroy
        flash[:notice] = 'Failed to update user_info.'
      end
    else
      falsh[:notice] = 'Failed to create instructor info.'
    end
    render('new')
  end

  def show
    @instructor_info = InstructorInfo.find(current_user.id)
  end

  def edit
    @instructor_info = InstructorInfo.find(current_user.id)
  end

  def update
    @instructor_info = InstructorInfo.find(current_user.id)
    if @instructor_info.update_attributes(instructor_info_params)
      flash[:notice] = 'Instructor profile updated successfully'
    end
    render('edit')
  end

  def destroy
    InstructorInfo.destroy(current_user.id)
    UserInfo.find(current_user.id).update_attribute(:is_instructor, false)
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
    :page_title,
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
    :price_base)
  end

end
