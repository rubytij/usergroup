class Post < ActiveRecord::Base
  belongs_to :user

  validates :title, :content, :user, :presence => true
  validates :title, :uniqueness => true

  default_scope :order => "created_at DESC"

  attr_accessible :title, :content
end
