require 'spec_helper'

describe 'PostsController#index layout' do
  before :each do
    @user = Factory.create :user
    @post = Factory.create :post, :user => @user
  end

  describe 'layout' do
    it 'should show could tag and avatar' do
      visit '/posts'
      page.should have_css( '.tag_cloud' )
      page.should have_css( '.avatar' )
    end

    it 'should show disqus elements' do
      visit user_post_path(@user.id, @post.id)
      page.should have_css( '#disqus_thread' )
      page.should have_css( '#dsq-comments-title' )
      page.should have_css( '#dsq-comments' )
      page.should have_css( '#dsq-new-post' )
      puts page.body.inspect
    end
  end
  describe 'create a new comment' do
    before { visit user_post_path(@user.id, @post.id) }

    describe 'with empty message' do
      it "should show a error message" do
        page.should_not have_css('#dsq-popup-message')
        #fill_in( "dsq-textarea-wrapper", "foo" )
        click_button( "dsq-post-button" )
        page.should have_css('#dsq-popup-message')
        page.should has_content?("Please enter a comment to post")
      end
    end
  end
end
