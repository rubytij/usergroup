class Page < ActiveRecord::Base
  extend FriendlyId

  belongs_to :section

  validates :name, :presence => true, :uniqueness => true
  validates :title, :content, :section_name, :presence => true

  before_save :relate_to_section

  attr_writer :section_name

  attr_accessible :name, :title, :content, :section_name

  friendly_id :name, :use => :slugged

  def section_name
    @section_name || section.try( :name )
  end

  private
  def relate_to_section
    section = Section.first_or_create( :name => section_name.downcase )
    self.section_id = section.id
  end
end
