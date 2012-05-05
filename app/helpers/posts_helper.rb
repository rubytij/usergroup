module PostsHelper
  include ActsAsTaggableOn::TagsHelper

  def post_cloud
    Post.tag_counts_on(:tags)
  end
end
