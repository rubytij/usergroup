require 'spec_helper'

describe Dashboard::PostsController do
  let(:user) { create :user }
  let(:user_post) { create :post, user: user }

  describe 'logged in' do
    before { session[:user_id] = user.id }

    describe :index do
      it 'should be successful' do
        get :index

        response.should be_success
        response.should render_template( :index )
      end
    end

    describe 'new' do
      it 'should respond successfully if logged in' do
        get :new
        response.status.should eql( 200 )
        response.should render_template( :new )
      end
    end

    describe 'create a new post' do
      it 'should redirect after creating post' do
        post :create, post: attributes_for( :post )
        response.should redirect_to( user_post_path( user, assigns(:post) ) )
      end

      it 'should render new if it fails' do
        post :create, post: attributes_for( :post, title: nil )
        response.should render_template( :new )
      end
    end

    describe 'with existing post' do
      it 'should render edit' do
        get :edit, id: user_post
        response.status.should eql( 200 )
        response.should render_template( :edit )
      end

      it 'should update and redirect' do
        user_post.tags.should be_empty
        put :update, id: user_post, post: { tag_list: 'updated' }
        response.should redirect_to( user_post_path user, user_post )
        user_post.reload.tags.count.should eql( 1 )
      end

      it 'should destroy existing post' do
        delete :destroy, id: user_post
        response.should redirect_to( dashboard_posts_path )
        Post.count.should eql( 0 )
      end
    end
  end

  describe 'not logged in' do
    describe 'new' do
      it do
        get :new
        response.status.should eql( 404 )
        response.should render_template( file: 'public/404' )
      end
    end

    describe 'create' do
      it do
        post :create, post: attributes_for( :post )
        response.status.should eql( 404 )
        response.should render_template( file: 'public/404' )
      end
    end
  end
end
