class SectionsController < ApplicationController
  #before_filter :authenticate_user!

  def index
    @sections = Section.all
  end

  def new
    @section = Section.new
  end

  def create
    @section = Section.new(params[:section])

    if @section.save
      flash[:success] = t 'sections.messages.create_success'
      redirect_to @section
    else
      render :new
    end
  end

  def show
    @section = Section.find params[:id]
  end
end
