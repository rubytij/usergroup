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
  end

  it "Create session for existing user" do
    OmniAuth.config.add_mock( :github, "uid" => @user.github_uid )
    visit '/auth/github'

    page.should have_content( I18n.t 'user.sessions.destroy' )
  end

  it "Create session for un-existing users" do
    OmniAuth.config.add_mock( :github, @omniauth )
    visit '/auth/github'

    page.should have_content( I18n.t 'user.sessions.destroy' )
    User.count.should be_eql( 2 )
  end

  it "Can destroy existing sessions" do
    OmniAuth.config.add_mock( :github, "uid" => @user.github_uid )
    visit '/auth/github'

    page.should have_content( I18n.t 'user.sessions.destroy' )

    page.click_link( I18n.t 'user.sessions.destroy' )
    current_path.should eql( '/' )
    page.should have_content( I18n.t 'user.sessions.sign_in' )
  end
end
