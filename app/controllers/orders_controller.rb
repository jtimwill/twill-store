class OrdersController < ApplicationController
  before_action :require_user

  def index
    @orders = Order.all
  end

  def create
    Order.create(user: current_user)
    redirect_to orders_path
  end

  def show
    @order = Order.find(params[:id])
  end
end
