class ApplicationController < ActionController::Base
  helper_method :current_user
  before_filter :set_locale

  rescue_from UserGroup::UserNotAuthenticated, :with => :unauthenticated_access

  protect_from_forgery

  def current_user
    User.find( session[:user_id] ) rescue nil
  end

  private
  def authenticate_user!
    raise UserGroup::UserNotAuthenticated unless current_user
  end

  def unauthenticated_access
    render :file => 'public/404', :format => :html, :status => :not_found
  end

  def set_locale
    session[:locale]  = params[:locale] if params[:locale].present?
    I18n.locale       = session[:locale]
  end
end
