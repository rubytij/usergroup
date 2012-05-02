class ApplicationController < ActionController::Base
  helper_method :current_user

  rescue_from UserGroup::UserNotAuthenticated, :with => :unathenticated_access

  protect_from_forgery

  def current_user
    User.find( session[:user_id] ) rescue nil
  end

  private
  def authenticate_user!
    raise UserGroup::UserNotAuthenticated unless current_user
  end

  def unauthenticated_access
    render :file => 'public/404', :format => :html
  end
end
