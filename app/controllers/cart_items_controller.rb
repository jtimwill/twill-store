class CartItemsController < ApplicationController
  before_action :require_user

  def index
    @cart_items = CartItem.all
  end

  def create
    CartItem.create(user: current_user)
    redirect_to cart_items_path
  end

  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.destroy if current_user.cart_items.include?(cart_item)
    redirect_to cart_items_path
  end
end
