class Page < ActiveRecord::Base
  extend FriendlyId

  before_save :check_main_page
  symbolize :section, :in => [ :home, :about, :contact, :meetings ], :scopes => true, :methods => true

  validates :name, :presence => true, :uniqueness => true
  validates :title, :content, :section, :presence => true

  attr_accessible :name, :title, :content, :section, :main_page

  friendly_id :name, :use => :slugged

  scope :latest, lambda { order( 'created_at DESC' ) }

  def self.main_page
    where( :main_page => true ).first or raise ActiveRecord::RecordNotFound
  end

  def check_main_page
    page = self.class.where( :main_page => true ).last
    page.update_attributes :main_page => false if page && page != self
  end
end
