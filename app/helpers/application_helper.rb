module ApplicationHelper

  def error_messages_for(object)
    render(:partial => 'application/error_messages', :locals => {:object => object})
  end

  # Call the function only if in_scope is true. Otherwise, returns whatever
  # is returned by the block, if there is one
  def scoped(in_scope, func, *args, &block)
    if in_scope
      public_send(func, *args, &block)
    else
      if block_given?
        capture(&block)
      end
    end
  end

  # Same as scoped, but don't return anything if in_scope is false.
  def scoped_tree(in_scope, func, *args, &block)
    if in_scope
      public_send(func, *args, &block)
    end
  end

  # returns the url of the user profile image.
  # TODO: handle it inside AvatarUploader
  def profile_image_of(user=current_user)
    avatar = UserInfo.find_by_id(user.id).avatar
    avatar.to_s.empty? ? asset_url('default_profile.png') : avatar
  end

  # assume signed in
  # If user is instructor, @instructor_info is automatically created.
  def user_is_instructor?
    @instructor_info = InstructorInfo.find_by_id(current_user.id)
    !@instructor_info.nil?
  end

  # A user can apply for instructor only if he is not already an instructor, and
  # there is no existing confirmed transactions.
  def can_apply_for_instructor?
    user_info = current_user.user_info
    user_info.instructor_info.nil? && user_info.consult_transactions.where(status: 'confirmed').empty?
  end

  def background
    puts "params::::::#{params}"
    params["controller"] == "profiles" ? "dark" : ""
  end

end
