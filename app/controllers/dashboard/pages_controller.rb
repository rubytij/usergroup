class Dashboard::PagesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_page, :only => [ :edit, :update ]

  access_control do
    allow :admin, :editor
  end

  layout 'dashboard'

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

  private
  def find_page
    @page = Page.find params[:id]
  end
end
