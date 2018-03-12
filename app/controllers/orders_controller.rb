class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @categoriesproduct = Categoriesproduct.select(:category_id).distinct
    @existing_categories = Category.all

    if current_user.try(:admin?)
      @orders = Order.all.order('created_at DESC')
      @pending_orders = Order.where(status: 'In Progress').order('created_at DESC')
      @rejected_orders = Order.where(status: 'Failed').order('created_at DESC')
    else
      @orders = current_user.orders.order('created_at DESC')
    end
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

  def authorized
    @order = Order.find(params[:id])
    @order.status = 'Delivered'
    if @order.save
      redirect_to user_orders_path
      flash[:notice] = 'Order ID: ' + @order.id.to_s + ' authorized' 
    else
      redirect_to user_orders_path
      flash[:alert] = 'Order ID: ' + @order.id.to_s + ' authorization failed' 
    end  
  end

  def unauthorized
    @order = Order.find(params[:id])
    @order.status = 'Failed'
    if @order.save
      redirect_to user_orders_path
      flash[:alert] = 'Order ID: ' + @order.id.to_s + ' rejected' 
    end  
  end

  private

  def order_params
    params.require(:product).permit(:status)
  end

end
