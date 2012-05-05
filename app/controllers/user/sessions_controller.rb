class User::SessionsController < ApplicationController
  after_filter :clear_return_to, :only => :create

  def login
    session[:return_to] = params[:return_to]
    redirect_to '/auth/github'
  end

  def create
    omniauth = request.env['omniauth.auth']
    user = User.find_by_github_uid( omniauth['uid'] ) || User.create_from_github( omniauth )
    session[:user_id] = user.id

    redirect_to ( session[:return_to] || root_path )
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  private
  def clear_return_to
    session[:return_to] = nil
  end
end
