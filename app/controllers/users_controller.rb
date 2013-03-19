class UsersController < ApplicationController
  skip_before_filter :authorize
  skip_before_filter :authorize_admin, :except => [:index]
  # GET /users
  # GET /users.json
  
  def index
    @users = User.order(:name)
    @cart = current_cart

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
    @cart = current_cart

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new
    @cart = current_cart

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])
    @cart = current_cart

    respond_to do |format|
      if @user.save
        if @user.role == "admin"
          format.html { redirect_to users_url, notice: 'User was successfully created.' }
          format.json { render json: @user, status: :created, location: @user }
        else
          format.html { redirect_to store_url, notice: 'Thanks for signing up! You can now log in with your new account.' }
          format.json { render json: @user, status: :created, location: @user }
        end
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to users_url, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @cart = current_cart

    @user = User.find(params[:id])
    begin
     @user.destroy
     flash[:notice] = "User deleted"
    rescue Exception => except
      flash[:notice] = except.message
    end
    
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end
end
