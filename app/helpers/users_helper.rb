module UsersHelper
  def is_current_user? user
    user == current_user
  end

end
