require 'spec_helper'

describe "Users requests" do
  before :each do
    @user = Factory.create :user
    @omniauth = {
      'uid' => Factory.next(:uid),
        'info' => {
          'nickname'  => Factory.next(:username),
          'email'     => Factory.next(:email),
          'name'      => 'John Doe'
        },
        'extra' => {}
    }

    visit root_path
  end

  describe "Existing user" do
    before :each do
      OmniAuth.config.add_mock( :github, "uid" => @user.github_uid )
      page.click_link I18n.t('user.sessions.sign_in')
    end

    it "Create session for existing user" do
      page.should have_content( I18n.t 'user.sessions.destroy' )
    end

    it "Can destroy existing sessions" do
      page.should have_content( I18n.t 'user.sessions.destroy' )

      page.click_link( I18n.t 'user.sessions.destroy' )
      current_path.should eql( root_path )
      page.should have_content( I18n.t 'user.sessions.sign_in' )
    end
  end

  describe "Un-existant user" do
    before :each do
      OmniAuth.config.add_mock( :github, @omniauth )
      page.click_link I18n.t('user.sessions.sign_in')
    end

    it "Create session for un-existing users" do
      page.should have_content( I18n.t 'user.sessions.destroy' )
      User.count.should be_eql( 2 )
    end
  end
end
