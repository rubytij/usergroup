class Dashboard::PagesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_page, only: [ :edit, :update, :destroy ]

  access_control do
    allow :admin, :editor
  end

  layout 'dashboard'

  def index
    @pages = Page.paginate page: params[:page]
  end

  def new
    @page = Page.new
  end

  def create
    @page = Page.new params[:page]

    if @page.save
      redirect_to section_page_path( @page.section, @page )
    else
      render :new
    end
  end

  def update
    if @page.update_attributes params[:page]
      redirect_to section_page_path( @page.section, @page )
    else
      render :edit
    end
  end

  def destroy
    @page.destroy
    redirect_to dashboard_pages_path
  end

  private
  def find_page
    @page = Page.find params[:id]
  end
end
