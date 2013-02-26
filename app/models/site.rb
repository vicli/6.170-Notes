class Site < ActiveRecord::Base
  attr_accessible :name, :url
  has_many :pages
  
  validates :name, :presence => true
  validates :url, :presence => true
  
  def visits
    return pages.inject(0) { |sum, page| page.visits + sum }
  end
end
