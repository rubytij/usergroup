module PostsHelper
  include ActsAsTaggableOn::TagsHelper

  def is_author? post
    post.user == current_user
  end

  def post_cloud
    Post.tag_counts_on(:tags)
  end

  def authored_by author, time
    t( 'posts.authored_by',
      :author => link_to( author, '#' ),
      :time   => time_ago_in_words( time )
    ).html_safe
  end
end
