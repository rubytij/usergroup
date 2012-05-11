class Section < ActiveRecord::Base
  has_many :pages

  validates :name, :uniqueness => true, :presence => true

  attr_accessible :name, :description
end
