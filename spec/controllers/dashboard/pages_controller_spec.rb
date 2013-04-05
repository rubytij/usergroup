require 'spec_helper'

describe Dashboard::PagesController do
  let( :new_page ) { create :page }

  describe 'logged in' do
    before do
      user = create :user
      user.has_role! :admin
      session[:user_id] = user.id
    end

    describe 'create new new_page' do
      it 'should redirect after creating new_page' do
        post :create, :page => attributes_for( :page )

        new_page = assigns :page
        response.should redirect_to( section_page_path( new_page.section, new_page ) )
      end

      it 'should render new on failure' do
        post :create, :section => attributes_for( :page, :name => nil)

        response.should render_template( :new )
      end
    end

    describe 'with existing new_page' do
      it 'should render edit' do
        get :edit, :id => new_page

        response.should be_success
        response.should render_template( :edit )
      end

      it 'should update and redirect' do
        put :update, :id => new_page, :page => { :name => 'updatednew_page' }

        new_page = assigns :page
        response.should redirect_to( section_page_path new_page.section, new_page )
        new_page.name.should eql('updatednew_page')
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
        post :create, :page => attributes_for( :page )
        response.status.should eql( 404 )
      end
    end

    describe 'edit' do
      it do
        get :edit, :id => page
        response.status.should eql( 404 )
      end

      it do
        put :update, :id => page, :page => attributes_for( :page )
        response.status.should eql( 404 )
      end
    end
  end
end
