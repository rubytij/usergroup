class Dashboard::PostsController < ApplicationController
  before_filter :authenticate_user!,    :only => [ :new, :create, :edit, :update, :destroy ]
  before_filter :find_post,             :only => [ :edit, :update, :destroy ]

  layout 'dashboard'

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

  def update
    if @post.update_attributes params[:post]
      redirect_to user_post_path current_user, @post
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end

  private
  def find_post
    @post = current_user.posts.find params[:id]
  end
end
