module DebugHelper

  TABLE_HEADERS = [:me, :id, :email, :first_name, :last_name, :created_at, :updated_at]

  def row_data(user_info)
    [
      user_signed_in? && user_info.id == current_user.id ? '*' : ' ',
      user_info.id,
      user_info.user.email,
      user_info.first_name,
      user_info.last_name,
      user_info.user.created_at,
      user_info.updated_at
    ]
  end
end
