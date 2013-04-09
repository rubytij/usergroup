require 'spec_helper'

describe 'PostsController#index layout' do
  before { @post = create :post }

  describe 'layout' do
    it 'should show could tag' do
      visit posts_path
      page.should have_css( '.tag_cloud' )
    end
  end

  describe 'comments' do
    it 'should show disqus elements', js: true do
      visit user_post_path( @post.user, @post )

      find('#disqus_thread')
      page.should have_css( '#dsq-content-stub' )
      page.should have_css( '#dsq-content' )

      find( '#dsq-comments' )
      page.should have_css( '#dsq-comments' )
      page.should have_css( '#dsq-new-post' )
    end
  end
end
