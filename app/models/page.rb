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
    where( :main_page => true ).first
  end

  def check_main_page
    Page.where( :main_page => true ).find_each( :batch_size => 100 ) do |page|
      page.update_attributes :main_page => false
    end

    self.main_page = true
  end
end
