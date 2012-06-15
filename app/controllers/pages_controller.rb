class PagesController < ApplicationController
  before_filter :authenticate_user!,  :only => [ :new, :create, :edit, :update, :destroy ]
  before_filter :find_page,           :only => [ :edit, :update ]

  def show
    @related  = Page.where( :section => params[:section_name] )
    @page     = @related.find params[:page_name]
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

  def main_page
    @page = Page.latest_main
  end

  private
  def find_page
    @page = Page.find params[:id]
  end
end
