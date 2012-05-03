require 'spec_helper'

describe User do
  before { @user = Factory.create :user }

  describe 'email' do
    it 'can be blank' do
      user = Factory.build :user, :email => ''
      user.should be_valid
    end

    it 'can be nil' do
      user = Factory.build :user, :email => nil
      user.should be_valid
    end

    it 'must be properly formatted' do
      user = Factory.build :user, :email => 'asdas'
      user.should be_invalid
    end

    it 'must be unique' do
      user = Factory.build :user, :email => @user.email
      user.should be_invalid
    end
  end

  describe 'username' do
    it 'must be present' do
      user = Factory.build :user, :username => nil
      user.should be_invalid
    end

    it 'must be unique' do
      user = Factory.build :user, :username => @user.username
      user.should be_invalid
    end
  end

  describe 'github_uid' do
    it 'must be present' do
      user = Factory.build :user, :github_uid => nil
      user.should be_invalid
    end

    it 'must be unique' do
      user = Factory.build :user, :github_uid => @user.github_uid
      user.should be_invalid
    end
  end

  describe 'create_from_github' do
    before :each do
      @omniauth = { 'uid' => Factory.next(:uid),
        'info' => {
          'nickname'  => Factory.next(:username),
          'email'     => Factory.next(:email),
          'name'      => 'John Doe'
        },

        'extra' => {}
      }
    end

    it 'can create user from omniauth hash' do
      user = User.create_from_github( @omniauth )
      user.should be_persisted
    end
  end

  describe 'posts associations' do
    it "should be an array" do
      @user.posts.is_a?(Array).should be_true
    end

    it "can have posts" do
      post = Factory.create( :post, :user => @user )
      @user.posts.include?( post ).should be_true
      @user.posts.count.should be(1)
    end

    it "can create posts" do
      @user.posts.should be_empty
      @user.posts.create( :title => "foo", :content => 'Lorem ipsum' )
      @user.posts.should_not be_empty
    end

    it "should have post in the right order" do
      older_post = Factory.create( :post, :user => @user, :created_at => 1.day.ago )
      newer_post = Factory.create( :post, :user => @user, :created_at => 1.hour.ago )
      @user.posts.should == [ newer_post, older_post ]
    end
  end

  describe ".roles" do
    it "includes roles assigned" do
      user = Factory.create( :user, :roles => 3.times.map{ Factory.create( :role ) } )
      user.roles.count.should eq(3)
    end
  end
end
