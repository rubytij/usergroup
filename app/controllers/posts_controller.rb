class PostsController < ApplicationController
  def show
    user  = User.find params[:user_id]
    @post = user.posts.find params[:id]
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
end
