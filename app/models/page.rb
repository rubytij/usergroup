class Page < ActiveRecord::Base
  extend FriendlyId

  symbolize :section, :in => [ :home, :about, :contact, :meetings ], :scopes => true, :methods => true

  validates :name, :presence => true, :uniqueness => true
  validates :title, :content, :section, :presence => true

  attr_accessible :name, :title, :content, :section

  friendly_id :name, :use => :slugged
end
