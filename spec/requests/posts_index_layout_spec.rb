require 'spec_helper'

describe 'PostsController#index layout' do
  before :each do
    @user = Factory.create :user
    @post = Factory.create :post, :user => @user
  end

  it 'should show could tag and avatar' do
    visit '/posts'
    page.should have_css( '.tag_cloud' )
    page.should have_css( '.avatar' )
  end
end
