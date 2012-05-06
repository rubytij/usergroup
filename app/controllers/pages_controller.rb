class PagesController < ApplicationController
  def index
    @pages = Page.all
  end

  def new
    @page = Page.new
  end

  def create
    @page = Page.new(params[:page])

    if @page.save
      flash[:sucess] = t"pages.messages.create_success"
      redirect_to @page
    else
      render :new
    end
  end

  def show
    @page = Page.find params[:id]
  end

  def edit
    @page = Page.find params[:id]
  end

  def update
    @page = Page.find(params[:id])

    if @page.update_attributes(params[:page])
      flash[:sucess] = t"pages.messages.update_success"
      redirect_to @page
    else
      render :edit
    end
  end
end
