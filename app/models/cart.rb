class Cart < ActiveRecord::Base
  attr_accessible :title, :body
  has_many :line_items, :dependent => :destroy
  has_many :products

  # Adds product to cart; first checks if product currently exists, 
  # and if it does, the quantity attribute is updated
  def add_product(product_id)
    current = line_items.where(:product_id => product_id).first
      if current
    		current.quantity += 1
    	else 
    		current = line_items.build(:product_id => product_id)
    	end
  	current
  end

  # Removes product from cart; If product exists and
  # is greater than one, decrease quantity. Else, product is destroyed from cart
  def remove_product(product_id)
    current = line_items.where(:product_id => product_id).first
    if current.quantity > 1
      current.quantity = current.quantity - 1
      current.save
      current
    else 
      current.destroy
    end
    current
  end

  # Sums individual product prices to find total price
  def total_price
    line_items.to_a.sum {|item| item.total_price}
  end
end
