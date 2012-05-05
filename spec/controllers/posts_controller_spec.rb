require 'spec_helper'

describe PostsController do
  before { @user = Factory.create :user }

  describe 'logged in' do
    before { session[:user_id] = @user.id }

    describe 'new' do
      it 'should respond successfully if logged in' do
        get :new
        response.status.should eql( 200 )
        response.should render_template( :new )
      end
    end

    describe 'create a new post' do
      it 'should redirect after creating post' do
        post :create, :post => Factory.attributes_for( :post )
        response.should redirect_to( user_post_path( @user, assigns(:post) ) )
      end

      it 'should render new if it fails' do
        post :create, :post => Factory.attributes_for( :post, :title => nil )
        response.should render_template( :new )
      end
    end

    describe 'index' do
      it 'should response succesfully' do
        get :index
        response.status.should eql( 200 )
        response.should render_template('index')
      end
    end
  end

  describe 'not logged in' do
    describe 'new' do
      it do
        get :new
        response.status.should eql( 404 )
        response.should render_template( :file => 'public/404' )
      end
    end

    describe 'create' do
      it do
        post :create, :post => Factory.attributes_for( :post )
        response.status.should eql( 404 )
        response.should render_template( :file => 'public/404' )
      end
    end

    describe 'show' do
      it 'should response successfully' do
        get :show, :user_id => @user, :id => Factory.create( :post, :user => @user )
        response.status.should eql( 200 )
        response.should render_template( 'show' )
      end
    end

    describe 'index' do
      it 'should response succesfully' do
        get :index
        response.status.should eql( 200 )
        response.should render_template('index')
      end
    end
  end
end
