class Page < ActiveRecord::Base
  belongs_to :section

  validates :name, :uniqueness => true, :presence => true
  validates :section, :presence => true

  attr_accessible :name, :section_id, :title, :tags, :content, :created_on, :created_by, :last_update, :last_update_by
end
