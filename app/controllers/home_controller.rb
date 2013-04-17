class HomeController < ApplicationController
    helper_method :total
  def index
  	# Secondary check that user has been signed in (this is already checked in view). User should only
  	# be able to access index page when logged in.
  	if user_signed_in?
  		@starred = Note.where(:starred => true)
	  	@user = current_user
	  	# Find notes that belongs to user. Notes are then reordered so that that starred notes are
	  	# displayed first, followed by unstarred notes, which are then ordered by time creatd.
	  	@notes = Note.where(:owner => @user.id).order("starred ASC").order("created_at")
	end
  end

  def total
    @count = Note.find(:all).count
  end
  def update
  	 @note = Note.find(params[:id])
  end
end
