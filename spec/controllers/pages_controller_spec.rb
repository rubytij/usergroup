require 'spec_helper'

describe PagesController do
  before { @page = Factory.create :page }

  describe 'not logged in' do
    describe 'show' do
      it do
        get :show, :page_name => @page.slug, :section_name => @page.section
        response.status.should eql( 200 )
        response.should render_template( 'show' )
      end
    end
  end
end
