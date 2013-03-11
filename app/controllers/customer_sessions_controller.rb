class CustomerSessionsController < ApplicationController
	skip_before_filter :authorize

  def new
  end

  def create
  	if customer = Customer.authenticate(params[:name], params[:password])
		customer_session[:customer_id] = customer.id
		redirect_to store_url
		else
		redirect_to customerlogin_url, :alert => "Invalid user/password combination"
	end
  end

  def destroy
  	customer_session[:customer_id] = nil
	redirect_to store_url, :notice => "Logged out"
  end
end
