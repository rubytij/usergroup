class PostsController < ApplicationController
  before_filter :find_user_with_params, only: [ :show, :index ]

  def index
    @posts = Post.user_filtered( @user, params[:tag] ).includes(:user).paginate page: params[:page], per_page: 10
  end

  def show
    @post = @user.posts.find params[:id]
  end

  private
  def find_user_with_params
    @user = User.find( params[:user_id] ) if params[:user_id].present?
  end
end
