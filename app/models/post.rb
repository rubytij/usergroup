class Post < ActiveRecord::Base
  attr_accessible :title, :content
  belongs_to :user

  validates :title, :content, :user_id, :presence => true
  validates :title, :uniqueness => true

  default_scope :order => "created_at DESC"
end
