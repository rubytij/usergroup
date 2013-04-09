require 'spec_helper'

describe PostsHelper do
  describe "authored_by" do
    before :each do
      @post = create :post
      @expected_string = I18n.t( 'posts.authored_by', author: ( helper.link_to @post.user, '#' ), time: ( helper.time_ago_in_words @post.created_at ) )
    end

    it do
      helper.authored_by( @post.user, @post.created_at ).should be_present
    end

    it do
      helper.authored_by( @post.user, @post.created_at ).should eql( @expected_string.html_safe )
    end
  end
end
