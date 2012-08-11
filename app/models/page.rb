class Page < ActiveRecord::Base
  extend FriendlyId

  SECTIONS = [ :home, :about, :meetings ]

  symbolize :section, :in => SECTIONS, :scopes => true, :methods => true

  validates :name, :presence => true, :uniqueness => { :scope => :section }
  validates :title, :content, :section, :presence => true

  attr_accessible :name, :title, :content, :section, :main_page

  friendly_id :name, :use => :scoped, :scope => :section

  scope :latest, lambda { order( 'created_at DESC' ) }

  def self.main
    where( :main_page => true ).first
  end

end
