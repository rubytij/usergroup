class PagesController < ApplicationController
  before_filter :find_page, :only => [:show, :edit, :update]
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
  end

  def edit
  end

  def update
    if @page.update_attributes(params[:page])
      flash[:sucess] = t"pages.messages.update_success"
      redirect_to @page
    else
      render :edit
    end
  end

  private
    def find_page
      @page = Page.find(params[:id])
    end
end
