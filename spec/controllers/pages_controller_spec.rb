require 'spec_helper'

describe PagesController do
  let(:new_page) { create :page }

  describe 'not logged in' do
    describe 'show' do
      it do
        get :show, :page_name => new_page.slug, :section_name => new_page.section
        response.should be_success
        response.should render_template( 'show' )
      end
    end
  end
end
