class Page < ActiveRecord::Base
  extend FriendlyId

  symbolize :section, :in => [ :home, :about, :contact, :meetings ], :scopes => true, :methods => true
  symbolize :main_page, :scopes => true, :methods => true

  validates :name, :presence => true, :uniqueness => true
  validates :title, :content, :section, :presence => true

  attr_accessible :name, :title, :content, :section

  friendly_id :name, :use => :slugged

  scope :latest, order( 'created_at DESC' )
  scope :latest_main, latest.where( :main_page => true )
end
