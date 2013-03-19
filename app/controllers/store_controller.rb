class StoreController < ApplicationController
	skip_before_filter :authorize
	skip_before_filter :authorize_admin

  # Sets locale for store
  def index
  	if params[:set_locale]
  		redirect_to store_path(:locale => params[:set_locale])
    else
	  	@products = Product.all
	  	@cart = current_cart
	end

  end
end
