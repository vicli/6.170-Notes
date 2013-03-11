class AdminController < ApplicationController
  def index
  	@cart = current_cart
  	@total_orders = Order.count
  	@orders = Order.all
  end
end
