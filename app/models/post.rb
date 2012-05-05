class Post < ActiveRecord::Base
  belongs_to :user

  validates :title, :content, :user, :presence => true
  validates :title, :uniqueness => true

  default_scope :order => "created_at DESC"

  attr_accessible :title, :content

  def self.latest( limit = 10 )
    find(:all, :limit => limit).reverse
  end
end
