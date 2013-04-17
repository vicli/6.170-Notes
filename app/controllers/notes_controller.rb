class NotesController < ApplicationController
  before_filter :load
  respond_to :json
  helper_method :total
 
  # Load is needed so that @user is not nil(for some reason AJAX note creation does not work without it)
  def load
    @user = current_user
  end

  # Helper method to allow in-place editing of ntoe
  def in_place_update
     @note = Note.find(params[:id])
     @note.update_attributes(:name, params[:text])

     respond_to do |format|
      format.js
     end
  end

  def total
    @count = Note.find(:all).count
  end

  # GET /notes
  # GET /notes.json
  def index
    @notes = Note.where(:owner => @user.id).order("starred DESC").order("created_at")
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @notes }
    end
  end

  # This method updates the "starred" attribute in the database to be true, 
  # and is invoked when the note is starred. It is called from a function within _note_body
  def star
    @notes = Note.where(:owner => @user.id).order("starred DESC").order("created_at")
    @note = Note.find(params[:dataid])

    @note.update_attributes(:starred => true)

    respond_to do |format|
      format.js
    end
  end

  # This method updates the "starred" attribute in the database to be false, 
  # and is invoked when the note is unstarred. It is called from a function within _note_body
  def staroff
    @notes = Note.where(:owner => @user.id).order("starred DESC").order("created_at")
    @note = Note.find(params[:dataid])
    @note.update_attributes(:starred => false)

    respond_to do |format|
      format.js
    end
  end

  # GET /notes/1
  # GET /notes/1.json
  def show
    @note = Note.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @note }
    end
  end

  # GET /notes/new
  # GET /notes/new.json
  def new
    @note = Note.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @note }
    end
  end

  # GET /notes/1/edit
  def edit
    @note = Note.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  # POST /notes
  # POST /notes.json
  def create
    @notes = Note.where(:owner => @user.id).order("starred DESC").order("created_at")
    @note = Note.new(params[:note])

    #Finds the id of current user and sets the owner of the note as this user's id. 
    @note.owner = current_user.id

    respond_to do |format|
      if @note.save
        format.html { redirect_to root_url, notice: 'Note was successfully created.' }
        format.json { render json: @note, status: :created, location: @note }
        format.js
      else
        format.html { render action: "new" }
        format.json { render json: @note.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # PUT /notes/1
  # PUT /notes/1.json
  def update
    @note = Note.find(params[:id])

    respond_to do |format|
      if @note.update_attributes(params[:note])
        format.html { redirect_to @note, notice: 'Note was successfully updated.' }
        format.json { respond_with_bip(@note) }
        format.js
      else
        format.html { render action: "edit" }
        format.json { respond_with_bip(@note) }
        format.js
      end
    end
  end

  # DELETE /notes/1
  # DELETE /notes/1.json
  def destroy
    @note = Note.find(params[:id])
    @note.destroy

    @notes = Note.where(:owner => @user.id).order("starred DESC").order("created_at")
    respond_to do |format|
      format.html { redirect_to root_url }
      format.json { head :no_content }
      format.js 
    end
  end
end
