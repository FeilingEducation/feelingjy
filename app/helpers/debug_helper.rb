module DebugHelper

  TABLE_HEADERS = [:me, :id, :email, :first_name, :last_name, :gender, :city, :about]

  def row_data(user_info)
    [
      user_signed_in? && user_info.id == current_user.id ? '*' : ' ',
      user_info.id,
      user_info.user.email,
      user_info.first_name,
      user_info.last_name,
      user_info.gender,
      user_info.city,
      user_info.about
    ]
  end
end
