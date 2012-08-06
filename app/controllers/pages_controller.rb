class PagesController < ApplicationController
  def show
    @related  = Page.where( :section => params[:section_name] )
    @page     = @related.find params[:page_name]
  end

  def contact
    @contact_form = ContactForm.new
  end

  def email
    @contact_form = ContactForm.new params[:contact_form]

    if @contact_form.deliver
      redirect_to contact_page_path, :flash => { :success => t('actions.sent', :item => t('activerecord.models.contact_form')) }
    else
      render :contact
    end
  end
end
