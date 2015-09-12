class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def require_user
    if !logged_in?
      flash[:danger] = "Must be logged in to do that."
      redirect_to login_path
    end
  end

  def require_items
    if current_user.cart_items.count == 0
      flash[:danger] = "Your cart is empty"
      redirect_to cart_path
    end
  end
end
