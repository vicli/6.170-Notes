class Cart < ActiveRecord::Base
  attr_accessible :title, :body
  has_many :line_items, :dependent => :destroy

  def add_product(product_id)
  	current = line_items.where(:product_id => product_id).first
  	if current
  		current.quantity += 1
  	else 
  		current = line_items.build(:product_id => product_id)
  	end
  	current
  end

  def remove_product(product_id)
    p "inremove"
    current = line_items.where(:product_id => product_id).first
    p current
    if current.quantity > 1
      current.quantity = current.quantity - 1
      current.save
      p "quantity is"
      p current.quantity
      current
      p current
    else 
      current.destroy
    end
    current
  end

  def total_price
    line_items.to_a.sum {|item| item.total_price}
  end
end
