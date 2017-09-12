module ApplicationHelper

  def error_messages_for(object)
    render(:partial => 'application/error_messages', :locals => {:object => object})
  end

  def user_profile_image
    avatar = current_user.user_info&.avatar
    avatar.to_s.empty? ? 'default_profile.png' : avatar
  end

  # assume signed in
  def user_is_instructor?
    !InstructorInfo.find_by_id(current_user.id).nil?
  end

end
