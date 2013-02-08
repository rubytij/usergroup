require 'spec_helper'

describe UsersController do
  let(:user) { Factory.create :user }

  describe "GET 'show'" do
    it "displays user profile" do
      get :show, :id => user
      response.should render_template( :show )
    end
  end

  context 'logged in' do

    before :each do
      session[:user_id] = user.id
    end

    describe "GET 'edit'" do

      it "shows edit form" do
        get :edit, :id => user
        response.status.should eql( 200 )
        response.should render_template( :edit )
      end

    end

    describe "PUT 'update'" do
      it "updates a user" do
        put :update, :id => user, :user => FactoryGirl.attributes_for(:user)
        user.reload
        response.should redirect_to( user_path( user ) )
      end
    end

  end

end
