class InstructorInfosController < AuthenticatedResourcesController

  before_action :check_user_info_initialized, except: [:states, :cities, :schools_applied,:index]
  before_action :check_instructor_info_initialized, except: [:states, :cities, :schools_applied,:index]

  # Notice that there is no index or show action for this controller.
  # Those are handled by the user_info controller depending on if the current_user
  # is an instructor.

  def index
    if params[:service].present? || params[:specialization].present?
      @results = InstructorInfo.search(params)
    else
      @results = InstructorInfo.limit(20)
    end
  end

  def new
    @instructor_info = InstructorInfo.new(min_price: 600, max_price: 800, consulting_tutor: true, brainstorming_tutor: true, writing_tutor: "false", visa_consultant:true)
  end

  def create
    @instructor_info = InstructorInfo.new(instructor_info_params)

    @instructor_info.id = current_user.id
    @instructor_info.uni_accepted = [instructor_info_params[:uni_accepted]]
    if @instructor_info.save!
      flash[:notice] = 'Instructor profile created successfully.'
      @instructor_info.user_info.update_attributes!(avatar: convert_data_uri_to_upload(params.require(:instructor_info)[:avatar_cache]))
      redirect_to(profile_path(@instructor_info))
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

  def states
    render json: CS.states(params[:country]).to_json
  end

  def cities
    render json: CS.cities(params[:state], params[:country]).to_json
  end

  def schools_applied
    # render json: InstructorInfo::SCHOOLS_APPLIED_BEFORE_ENGLISH[0..params['idx'].to_i]
    render json: InstructorInfo::UNIVERSITIES_ENGLISH
  end

  private

  # Convert base64 to binary
def split_base64(uri_str)
  if uri_str.match(%r{^data:(.*?);(.*?),(.*)$})
    uri = Hash.new
    uri[:type] = $1 # "image/gif"
    uri[:encoder] = $2 # "base64"
    uri[:data] = $3 # data string
    uri[:extension] = $1.split('/')[1] # "gif"
    return uri
  else
    return nil
  end
end

# Convert data uri to uploaded file. Expects object hash, eg: params[:profile_image]
def convert_data_uri_to_upload(obj_hash)
  puts "========#{obj_hash}"
  # if obj_hash.try(:match, %r{^data:(.*?);(.*?),(.*)$})
    image_data = split_base64(obj_hash)
    image_data_string = image_data[:data]
    image_data_binary = Base64.decode64(image_data_string)

    temp_img_file = Tempfile.new("data_uri-upload")
    temp_img_file.binmode
    temp_img_file << image_data_binary
    temp_img_file.rewind

    img_params = {:filename => "data-uri-img.#{image_data[:extension]}", :type => image_data[:type], :tempfile => temp_img_file}
    uploaded_file = ActionDispatch::Http::UploadedFile.new(img_params)

    #
    # obj_hash[:image] = uploaded_file
    # obj_hash.delete(:remote_image_url)
  # end

  uploaded_file
end

  def instructor_info_params
    params.require(:instructor_info).permit(
      # :consult_experience,
      # :previous_applications,
      # :previous_offers,
      # :gpa,
      # :gre_score,
      # :suggestions_to_students,
      # :specialties,
      # :available_time_slots,
      # :busy_events,
      # :is_early_consult,
      # :is_brainstorm_consult,
      # :is_essay_consult,
      # :is_visa_consult,
      # :consult_capacity_min,
      # :consult_capacity_max,
      # :consult_term_min,
      # :consult_term_max,
      # :consult_duration_min,
      # :consult_duration_max,
      # :consult_reserve_earliest,
      # :consult_reserve_latest,
      # :consult_frequency,
      # :privacy_policy_template,
      # :pricing_strategy,
      # :price_min,
      # :price_max,
      # :price_base,
      # :page_title,
      # :page_background,
      # :about_me,
      # :url_linked_in,
      :consult_experience,
      :previous_applications,
      :previous_offers,
      :gpa,
      :gre_score,
      :suggestions_to_studen,
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
      :price_base,
      :avg_rating,
      :url_linked_in,
      :page_background,
      :about_me,
      :university,
      :specialization,
      :degree_completed,
      :consulting_tutor,
      :brainstorming_tutor,
      :writing_tutor,
      :visa_consultant,
      :helped_before,
      :country,
      :state,
      :city,
      :description,
      :share_edited_files,
      :share_info,
      :meet_in_person,
      :answer_free,
      :personal_questions,
      :accomplishment,
      :free_time,
      :how_to_write,
      :nervous,
      :care_cooperation,
      :ensure_accurate_time,
      :max_std_count,
      :tutor_before,
      :min_work_days,
      :max_work_days,
      :advance_notify,
      :reserve_advance,
      :recommended_price,
      :min_price,
      :max_price,
      :fix_price,
      :work_frequency,
      :first_std_discount,
      :uni_accepted,
      :number_institutes_applied,
      :share_resume,
      :share_application_essay,
      :share_offer_letter,
      :share_gpa,
      :share_gre_score,
      :share_paper,
      :share_course_essay,
      :page_background_cache,
      :best_applying_at,
      :page_name
      # :avatar
    )
  end
end
