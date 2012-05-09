class SectionsController < ApplicationController
  before_filter :find_section, :only => [:show, :edit, :update]

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
  end

  def edit
  end

  def update
    if @section.update_attributes(params[:section])
      flash[:success] = t 'sections.messages.edit_success'
      redirect_to @section
    else
      render :edit
    end
  end

  private
    def find_section
      @section = Section.find(params[:id])
    end
end
