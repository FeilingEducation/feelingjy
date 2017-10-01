module ApplicationHelper

  def error_messages_for(object)
    render(:partial => 'application/error_messages', :locals => {:object => object})
  end

  def profile_image_of(user=current_user)
    avatar = UserInfo.find_by_id(user.id).avatar
    avatar.to_s.empty? ? 'default_profile.png' : avatar
  end

  # assume signed in
  def user_is_instructor?
    @instructor = InstructorInfo.find_by_id(current_user.id)
    !@instructor.nil?
  end

  def editable_image_tag(editable, source, options={})
    tag = image_tag source, options
    unless editable
      tag
    else
      render partial: 'editable_image_tag' do
        tag
      end
    end
  end

  def can_apply_for_instructor?
    user_info = current_user.user_info
    user_info.instructor_info.nil? && user_info.consult_transactions.where(status: 'confirmed').empty?
  end

end
