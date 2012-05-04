class SectionController < ApplicationController
  #before_filter :authenticate_user!

  def index
    @section = Section.new(:name =>'test', :url_friendly_name => 'test2')
  end

  def new
  end

  def create
  end

  def show
  end
end
