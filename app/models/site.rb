class Site < ActiveRecord::Base
  attr_accessible :name, :url
  has_many :pages
  
  validates :name, :presence => true
  validates :url, :presence => true
end
