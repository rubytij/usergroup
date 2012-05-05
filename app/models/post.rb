class Post < ActiveRecord::Base
  belongs_to :user

  validates :title, :content, :user, :presence => true
  validates :title, :uniqueness => true

  default_scope :order => "created_at DESC"

  attr_accessible :title, :content, :tag_list

  acts_as_taggable

  def self.user_filtered user, tag=nil
    posts = user ? user.posts : self
    return posts unless tag.present?

    posts.tagged_with tag
  end
end
