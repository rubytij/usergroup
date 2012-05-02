class PostsController < ApplicationController
  def index
  end

  def show
    @post = Post.find params[:id]
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new params[:post]
    if @post.save
      flash[:success] = t 'posts.messages.create_success'
      redirect_to @post
    else
      render :new
    end
  end
end
