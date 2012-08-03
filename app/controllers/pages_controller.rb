class PagesController < ApplicationController
  def show
    @related  = Page.where( :section => params[:section_name] )
    @page     = @related.find params[:page_name]
  end
end
