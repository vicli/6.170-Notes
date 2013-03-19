class StoreController < ApplicationController
	skip_before_filter :authorize
	skip_before_filter :authorize_admin
  def index
  	@products = Product.all
  	@cart = current_cart
  end
end
