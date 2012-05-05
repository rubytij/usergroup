class PostsController < ApplicationController
  before_filter :authenticate_user!,    :only => [ :new, :create ]
  before_filter :find_user_with_params, :only => [ :show, :index ]

  def index
    @posts = Post.user_filtered( @user, params[:tag] ).paginate :page => params[:page], :per_page => 10
  end

  def show
    @post = @user.posts.find params[:id]
  end

  def new
    @post = current_user.posts.new
  end

  def create
    @post = current_user.posts.build params[:post]

    if @post.save
      flash[:success] = t 'posts.messages.create_success'
      redirect_to user_post_path current_user, @post
    else
      render :new
    end
  end

  private
  def find_user_with_params
    @user = User.find( params[:user_id] ) if params[:user_id].present?
  end
end
