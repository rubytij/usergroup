require 'spec_helper'

describe PostsController do
  before :each do
    @user = Factory.create :user
  end

  describe "new" do
    before { PostsController.any_instance.stubs( :current_user ).returns @user }

    it "should response successfully" do
      get :new
      response.status.should be( 200 )
    end

    it "should render the right template" do
      get :new
      response.should render_template( :new )
    end
  end

  describe "show" do
    it "should response successfully" do
      get :show, :user_id => @user, :id => ( Factory.create :post, :user_id => @user )
      response.status.should be( 200 )
    end
  end

  describe "create a new post" do
    before { @controller.stubs(:current_user).returns( @user ) }

    it "should redirect after creating post" do
      post :create, :post => { :title => "foo", :content => "blab" }
      response.should redirect_to( user_post_path( @user, assigns(:post) ) )
    end

    it "should render new if it fails" do
      post :create, :post => { :title => "foo", :content => nil }
      response.should render_template( :new )
    end
  end
end
