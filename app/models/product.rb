class Product < ActiveRecord::Base
  attr_accessible :description, :image_url, :price, :title
  default_scope :order => 'title'

  has_many :line_items
  has_many :orders, :through => :line_items

  before_destroy :ensure_unreferenced_by_line_items

  # Ensures that products have no reference to them 
  # before destroying
  def ensure_unreferenced_by_line_items
  	if line_items.count.zero?
  		return true
  	else
  		errors.add(:base, 'Line items are present')
  		return fasle
  	end
  end
  
  # Checks that title and description exists
  validates :title, :description, :presence => true
  # Checks that price is greater than 0.01 cents
  validates :price, :numericality => {:greater_than_or_equal_to => 0.01}
  # Checks that the product isn't already entered into the database
  validates :title, :uniqueness => true

end
