class Section < ActiveRecord::Base
  extend FriendlyId

  has_many :pages

  validates :name, :uniqueness => true, :presence => true
  attr_accessible :name

  friendly_id :name, :use => :slugged
end
