class Page < ActiveRecord::Base
  extend FriendlyId

  Sections = [ :home, :about, :meetings ]

  symbolize :section, in: Sections, scopes: :shallow, methods: true

  validates :name, presence: true, uniqueness: true
  validates :title, :content, :section, presence: true
  validate  :main_page_selection

  attr_accessible :name, :title, :content, :section, :main_page

  friendly_id :name, use: :slugged

  scope :latest, lambda { order( 'created_at DESC' ) }

  def self.main
    where( main_page: true ).first
  end

  private
  def main_page_selection
    if main_page?
      Page.where( "main_page = ?", true ).each do |page|
        page.update_attributes( main_page: false ) if page.present? && page != self
      end
    end
  end
end
