class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @categoriesproduct = Categoriesproduct.select(:category_id).distinct
    @existing_categories = Category.all

    @orders = current_user.orders
  end

  def show
    @categoriesproduct = Categoriesproduct.select(:category_id).distinct
    @existing_categories = Category.all

    @products = Ordersproduct.all.where(order_id: params[:id])
    @uniq_products = Order.find(params[:id]).products.uniq
  end

  def create
    order = $redis.hgetall current_user.id
    Order.create(user_id: current_user.id, status: 'In Progress')
    order.each do |product, qty| 
      qty.to_i.times do
        Ordersproduct.create(product_id: product.to_i, order_id: Order.last.id)
      end
    end
    $redis.del current_user.id
    redirect_to user_orders_path
  end



end
