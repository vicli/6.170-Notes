class HomeController < ApplicationController
  def index
  	if user_signed_in?
  		p current_user 
	  	@user = current_user
	  	@notes = Note.where(:owner => @user.id)
	end
  end
end
