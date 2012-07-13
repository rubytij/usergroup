require 'spec_helper'

describe Dashboard::PagesController do
  before { @page = Factory.create :page }

  describe 'logged in' do
    before { session[:user_id] = Factory.create( :user ).id }

    describe 'create new page' do
      it 'should redirect after creating page' do
        post :create, :page => Factory.attributes_for( :page )

        page = assigns :page
        response.should redirect_to( section_page_path( page.section, page ) )
      end

      it 'should render new on failure' do
        post :create, :section => Factory.attributes_for( :page, :name => nil)

        response.should render_template( :new )
      end
    end

    describe 'with existing page' do
      it 'should render edit' do
        get :edit, :id => @page
        response.status.should eql(200)
        response.status.should render_template( :edit )
      end

      it 'should update and redirect' do
        put :update, :id => @page, :page => { :name => 'updatedpage' }

        page = assigns :page
        response.should redirect_to( section_page_path page.section, page )
        page.name.should eql('updatedpage')
      end
    end
  end

  describe 'not logged in' do
        describe 'new' do
      it do
        get :new
        response.status.should eql( 404 )
      end

      it do
        post :create, :page => Factory.attributes_for( :page )
        response.status.should eql( 404 )
      end
    end

    describe 'edit' do
      it do
        get :edit, :id => @page
        response.status.should eql( 404 )
      end

      it do
        put :update, :id => @page, :page => Factory.attributes_for( :page )
        response.status.should eql( 404 )
      end
    end
  end
end
