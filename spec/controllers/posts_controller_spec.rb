require 'spec_helper'

describe PostsController do
  let(:user) { Factory.create :user }

  describe 'not logged in' do
    describe 'show' do
      it 'should response successfully' do
        get :show, :user_id => user, :id => Factory.create( :post, :user => user )
        response.status.should eql( 200 )
        response.should render_template( 'show' )
      end
    end
  end

  describe 'not filtered by users' do
    before { 5.times { |n| Factory.create :post, :user => user, :tag_list => "tag#{n}" } }

    it 'should render all posts paginated' do
      get :index
      posts = assigns( :posts )
      posts.count.should eql( 5 )
    end

    it 'should filter by tag' do
      get :index, :tag => 'tag1'
      posts = assigns( :posts )
      posts.count.should eql( 1 )
    end
  end

  describe 'filtered by user' do
    before  { 2.times { |n| Factory.create :post, :user => user, :tag_list => "tag#{n}" } }

    it 'should suceed' do
      get :index, :user_id => user
      posts = assigns( :posts )
      posts.count.should eql( 2 )
      response.status.should eql( 200 )
      response.should render_template( 'index' )
    end

    it 'should filter by tag' do
      get :index, :user_id => user, :tag => 'tag1'
      posts = assigns( :posts )
      posts.count.should eql( 1 )
      response.status.should eql( 200 )
    end
  end
end
