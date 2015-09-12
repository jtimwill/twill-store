class OrdersController < ApplicationController
  before_action :require_user
  # before_action :require_items, only: [:new]

  def new
    @free_shipping = ShippingOption.find_by(title: 'Free Shipping (5-8 business days)')
    @standard_shipping = ShippingOption.find_by(title: 'Standard Shipping (4-5 business days)')
    @cart_items = CartItem.all
    @order = Order.new
  end

  def create
    shipping = ShippingOption.find_by(id: stripe_params[:optionsRadios])
    total = (shipping.cost + current_user.cart_total).to_i
    @order = Order.new(total: total, user: current_user, reference_id: stripe_params[:stripeToken])

    charge = StripeWrapper::Charge.create(
      amount: total,
      source: stripe_params[:stripeToken],
      description: "Order"
    )
    if charge.successful?
      @order.save
      AppMailer.delay.send_order_summary_email(current_user)
      flash[:success] = "Order Successful"
      clear_cart
      redirect_to user_path(current_user)
    else
      flash.now[:danger] = charge.error_message
      render "users/show"
    end
  end

  def show
    @order = Order.find(params[:id])
  end

  private

  def stripe_params
    params.permit(:stripeToken, :amount, :optionsRadios)
  end

  def clear_cart
    current_user.cart_items.each do |item|
      item.destroy
    end
  end
end
