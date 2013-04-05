require 'spec_helper'

describe "Users requests" do
  let(:user) { create :user }
  let(:omniauth) do
    {
      'uid' => generate( :uid ),
        'info' => {
          'nickname'  => generate( :username ),
          'email'     => generate( :email ),
          'name'      => 'John Doe'
        },
      'extra' => {}
    }
  end

  before :each do
    create :page
    visit root_path
  end

  describe "Existing user" do
    before :each do
      OmniAuth.config.add_mock( :github, "uid" => user.github_uid )
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
      OmniAuth.config.add_mock( :github, omniauth )
      page.click_link I18n.t('user.sessions.sign_in')
    end

    it "Create session for un-existing users" do
      page.should have_content( I18n.t 'user.sessions.destroy' )
      User.count.should be_eql( 1 ) # user no longer created by default
    end
  end
end
