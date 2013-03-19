class SessionsController < ApplicationController
  skip_before_filter :authorize
  skip_before_filter :authorize_admin
  
  def new
  end

  # Creates a new user session by first authenticating user then storing the user_id
  def create
  	if user = User.authenticate(params[:name], params[:password])
  		session[:user_id] = user.id

      # Redirects to different pages depending on type of user. 
      if user.role == "admin"
  		  redirect_to admin_url 
      else
        redirect_to store_index_path
      end 
  	else
  		redirect_to login_url, :alert => "Invalid user/password"
  	end
  end

  # Destroys user session when user logs out
  def destroy
  	session[:user_id] = nil
  	redirect_to store_url, :notice => "Logged out"
  end
end
