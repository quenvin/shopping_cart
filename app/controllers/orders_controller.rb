class OrdersController < ApplicationController

  def index
    @orders = current_user.orders.all
    user = current_user
    cart = current_user.orders.last
  end

  def edit
    @order = current_user.orders.last
  end

end
