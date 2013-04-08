class NotesController < ApplicationController
  before_filter :load
  respond_to :json
 
  #Pre loads notes/user data for easy access. 
  def load
    @user = current_user
    if @user != nil
      @notes = Note.where(:owner => @user.id)

    end
  end

  def in_place_update
     @note = Note.find(params[:id])
     @note.update_attributes(:name, params[:text])

     respond_to do |format|
      format.js
     end
  end

  # GET /notes
  # GET /notes.json
  def index
    @notes = Note.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @notes }
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
  end

  # POST /notes
  # POST /notes.json
  def create
    @note = Note.new(params[:note])

    #Finds the id of current user and uses this to identify owner of note. 
    @user = current_user.id
    @note.owner = @user

    respond_to do |format|
      if @note.save
        format.html { redirect_to root_url, notice: 'Note was successfully created.' }
        format.json { render json: @note, status: :created, location: @note }
        # Formats create.js.erb
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
      else
        format.html { render action: "edit" }
        format.json { respond_with_bip(@note) }
      end
    end
  end

  # DELETE /notes/1
  # DELETE /notes/1.json
  def destroy
    @note = Note.find(params[:id])
    @note.destroy

    respond_to do |format|
      format.html { redirect_to root_url }
      format.json { head :no_content }
      # Formates destroy.js.erb
      format.js 
    end
  end
end
