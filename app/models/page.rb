class Page < ActiveRecord::Base
  extend FriendlyId

  belongs_to :section

  validates :title, :presence => true, :uniqueness => true
  validates :name, :section, :content, :presence => true

  attr_accessible :name, :section_id, :section, :title, :content

  friendly_id :name, :use => :slugged
end
