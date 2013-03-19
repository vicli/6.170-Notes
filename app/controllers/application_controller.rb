class ApplicationController < ActionController::Base
  before_filter :set_i18n
#  before_filter :authorize_normal
  before_filter :authorize
  before_filter :authorize_admin
  before_filter :set_i18n
  protect_from_forgery


  include ApplicationHelper
  
  # Checks is user is logged in. 
  def user_is_logged_in?
    !!session[:user_id]
  end

  private

  # Searches for the cart based on cart_id; if id doesn't exist
  # a new cart is created.
  def current_cart
  	Cart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
  	cart = Cart.create
  	session[:cart_id] = cart.id
  	cart
  end

  protected

    #Sets authorization to check of User is logged in
    def authorize   
      user = User.find_by_id(session[:user_id]) 
      unless user
          redirect_to login_url, :notice => "Please log in"
      end
    end

    #Sets authorization to check of user is an admin
    def authorize_admin
      if user = User.find_by_id(session[:user_id])
        unless user.role == "admin"
          redirect_to login_url, :notice => "You don't have permissions to view this page"
        end
      end
    end

    #Sets the local language
    def set_i18n
      if params[:locale]
        if I18n.available_locales.include?(params[:locale].to_sym)
          I18n.locale = params[:locale]
        else
          flash.now[:notice] = "#{params[:locale]} not available"
          logger.error flash.now[:notice]
        end
      end
    end

    #Default options for internationalization feature
    def default_url_options
      {:locale => I18n.locale}
    end

end
