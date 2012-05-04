class Section < ActiveRecord::Base
  validates :name, :uniqueness => true, :presence => true

  attr_accessible :name, :url_friendly_name, :description
end
