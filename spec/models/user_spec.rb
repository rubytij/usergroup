require 'spec_helper'

describe User do
  let(:existing_user) { create :user }

  describe 'email' do
    it 'can be blank' do
      user = build :user, email: ''
      user.should be_valid
    end

    it 'can be nil' do
      user = build :user, email: nil
      user.should be_valid
    end

    it 'must be properly formatted' do
      user = build :user, email: 'asdas'
      user.should be_invalid
    end

    it 'must be unique' do
      user = build :user, email: existing_user.email
      user.should be_invalid
    end
  end

  describe 'username' do
    it 'must be present' do
      user = build :user, username: nil
      user.should be_invalid
    end

    it 'must be unique' do
      user = build :user, username: existing_user.username
      user.should be_invalid
    end
  end

  describe 'github_uid' do
    it 'must be present' do
      user = build :user, github_uid: nil
      user.should be_invalid
    end

    it 'must be unique' do
      user = build :user, github_uid: existing_user.github_uid
      user.should be_invalid
    end
  end

  describe 'create_from_github' do
    before :each do
      @omniauth = { 'uid' => generate( :uid ),
        'info' => {
          'nickname'  => 'github_user',
          'email'     => generate( :email ),
          'name'      => 'John Doe'
        },

        'extra'       => {},
        'credentials' => { token: 'abc123' }
      }
    end

    it 'should create roles of from github' do
      user =  User.create_from_github( @omniauth )
      user.roles.should_not be_empty
      user.should have_role( 'owners' ) # baffled by how this works, check spec_helper.rb
    end

    it 'can create user from omniauth hash' do
      user = User.create_from_github( @omniauth )
      user.should be_persisted
    end
  end

  describe 'posts associations' do
    it "should be an array" do
      existing_user.posts.is_a?(Array).should be_true
    end

    it "can have posts" do
      post = create( :post, user: existing_user )
      existing_user.posts.include?( post ).should be_true
      existing_user.posts.count.should be(1)
    end

    it "can create posts" do
      existing_user.posts.should be_empty
      existing_user.posts.create( title: "foo", content: 'Lorem ipsum' )
      existing_user.posts.should_not be_empty
    end
  end

  describe "roles association" do
    it "includes roles assigned" do
      user = create( :user )
      3.times { user.has_role! create( :role ) }
      user.roles.count.should eq(3)
    end

    it 'creates an enrollment per role' do
      existing_user.roles.should be_empty
      existing_user.has_role! :foo

      existing_user.roles.length.should       eql(1)
      existing_user.enrollments.length.should eql(1)
    end
  end

  describe 'gravatar_url' do
    before { existing_user.update_attributes! gravatar_token: '30f39a09e233e8369dddf6feb4be0308' }

    it 'should return gravatar url' do
      existing_user.gravatar_url.should =~ /30f39a09e233e8369dddf6feb4be0308/
    end

    it 'should return with desired size' do
      existing_user.gravatar_url(64).should =~ /s=64/
    end
  end
end
