require 'spec_helper'

describe "Users requests" do
  let(:user) { Factory.create :user }
  let(:omniauth) do
    {
      'uid' => Factory.next(:uid),
        'info' => {
          'nickname'  => Factory.next(:username),
          'email'     => Factory.next(:email),
          'name'      => 'John Doe'
        },
      'extra' => {}
    }
  end

  before :each do
    Factory.create :page
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

    it "Displays user profile" do
      visit user_path( user )
      page.should have_content user.name
    end

    it "Can edit his profile" do
      visit user_path( user )
      page.click_link I18n.t('user.registrations.edit')
      current_path.should eql( edit_user_path( user ) )
      page.fill_in I18n.t( 'activerecord.attributes.user.username' ), :with => 'pacoelchato'
      page.click_button I18n.t( 'user.registrations.edit' )
      user.reload
      current_path.should eql( user_path( user ) )
      user.username.should eql( 'pacoelchato' )
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
