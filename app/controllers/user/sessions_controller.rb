class User::SessionsController < ApplicationController
  def create
    omniauth = request.env['omniauth.auth']
    user = User.find_by_github_uid( omniauth['uid'] ) || User.create_from_github( omniauth )
    session[:user_id] = user.id

    redirect_to root_path
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
