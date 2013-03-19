class LineItemsController < ApplicationController
  #skip_before_filter :authorize_normal
  skip_before_filter :authorize
  skip_before_filter :authorize_admin
  # GET /line_items
  # GET /line_items.json
  def index
    @line_items = LineItem.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @line_items }
    end
  end

  # GET /line_items/1
  # GET /line_items/1.json
  def show
    @line_item = LineItem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @line_item }
    end
  end

  # GET /line_items/new
  # GET /line_items/new.json
  def new
    @line_item = LineItem.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @line_item }
    end
  end

  # GET /line_items/1/edit
  def edit
    @line_item = LineItem.find(params[:id])
  end

  # POST /line_items
  # POST /line_items.json

  # Creates a new LineItem when a product is added to cart.
  # Calls method in cart model that adds product to the cart listing.
  # Subtracts from quantity of product. If quantity is 0, customer is informed that product is out of stock. 
  def create
    @cart = current_cart
    product = Product.find(params[:product_id])

    if product.quantity > 0 
      @line_item = @cart.add_product(product.id)
      product.update_attributes(:quantity => product.quantity - 1)
    end

    respond_to do |format|
      if @line_item
        if @line_item.save
          format.html { redirect_to store_url}
          format.js { @current_item = @line_item}
          format.json { render json: @line_item, status: :created, location: @line_item }
        else
          format.html { render action: "new" }
          format.json { render json: @line_item.errors, status: :unprocessable_entity }
        end
      else
        format.html {redirect_to store_url, :notice => 'Sorry! Looks like that product is out of stock'}
      end
    end
  end

  # DELETE /line_items/1
  # DELETE /line_items/1.json

  #Removes product from cart; calls remove_product method in cart.
  # When product is moved, quantity attribute is updated so that the product in cart is
  # "returned" to the main inventory.
  
  def destroy
    @cart = current_cart
    product = Product.find(params[:product_id])
    #@line_item = LineItem.find(params[:id])
    @line_item = @cart.remove_product(product.id)
    product.update_attributes(:quantity => product.quantity + 1)

    respond_to do |format|
      format.html { redirect_to store_url }
      format.json { head :no_content }
    end
  end

  # PUT /line_items/1
  # PUT /line_items/1.json
  def update
    @line_item = LineItem.find(params[:id])

    respond_to do |format|
      if @line_item.update_attributes(params[:line_item])
        format.html { redirect_to @line_item, notice: 'Line item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end




end
