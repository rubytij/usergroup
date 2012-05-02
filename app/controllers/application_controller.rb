class ApplicationController < ActionController::Base
  helper_method :current_user

  protect_from_forgery

  def current_user
    User.find( session[:user_id] ) rescue nil
  end
end
