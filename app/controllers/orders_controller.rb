class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @orders = current_user.orders
  end

  def show
    @products = Ordersproduct.all.where(order_id: params[:id])
    @uniq_products = Order.find(params[:id]).products.uniq
  end


end
