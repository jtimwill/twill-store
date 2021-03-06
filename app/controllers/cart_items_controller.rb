class CartItemsController < ApplicationController
  before_action :require_user
  before_action :require_items, only: [:update_cart]

  def index
    @cart_items = CartItem.all
  end

  def create
    product = Product.find(params[:product_id])
    if new_item?(product)
      CartItem.create(user: current_user, product: product, quantity: params[:quantity])
    else
      cart_item = CartItem.find_by(product_id: params[:product_id])
      cart_item.update!(quantity: cart_item.quantity + params[:quantity].to_i)
    end
    redirect_to cart_path
  end

  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.destroy if current_user.cart_items.include?(cart_item)
    redirect_to cart_path
  end

  def update_cart
    update_cart_items
    redirect_to cart_path
  end

  private

  def update_cart_items
    ActiveRecord::Base.transaction do
      params[:cart_items].each do |cart_item_data|
        cart_item = CartItem.find(cart_item_data["id"])
        if cart_item.user == current_user
          cart_item.update!(quantity: cart_item_data["quantity"])
        end
      end
    end
  end

  def new_item?(product)
    !current_user.cart_items.map(&:product).include?(product)
  end
end
