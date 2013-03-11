class CombineItems < ActiveRecord::Migration
  def up
  	# replace all multiple entries with one entry
  	Cart.all.each do |cart|
  		sums = cart.line_items.group(:product_id).sum(:quantity)

  		# Delete all the entries (if there are multiple) and replacing with single
  		sums.each do |product_id, quantity|
  			if quantity > 1
  				cart.line_items.where(:product_id => product_id).delete_all
  				cart.line_items.create(:product_id => product_id, :quantity => quantity)


  end

  # When we want to decrease quantity 
  def down
  	LineItem.where("quantity > 1").each do |lineitem|
  		lineitem.quantity.items do
  			LineItem.create :cart_id => lineitem.cart_id, :product_id => lineitem.product_id, :quantity => 1
  		end
  	lineitem.destroy
  end
end
