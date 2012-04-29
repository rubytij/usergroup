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
end
