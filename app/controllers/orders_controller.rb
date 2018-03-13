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
    @order_details = Order.includes(:user).find(params[:id])
  end

  def new
    gon.client_token = generate_client_token
    @categoriesproduct = Categoriesproduct.select(:category_id).distinct
    @existing_categories = Category.all
    @cart = $redis.hgetall current_user.id
  end

  def create
    result = Braintree::Transaction.sale(
      amount: params[:total],
      payment_method_nonce: params[:payment_method_nonce])
      if result.success?
        order = $redis.hgetall current_user.id
        Order.create(user_id: current_user.id, transaction_num: result.transaction.id, status: 'In Progress')
        
        order.each do |product, qty| 
          qty.to_i.times do
          Ordersproduct.create(product_id: product.to_i, order_id: Order.last.id)
          end
        end
        
        $redis.del current_user.id
        flash[:notice] = "Checkout completed"
        redirect_to root_url
      else
        flash[:alert] = "Something went wrong while processing your transaction. Please try again!"
        gon.client_token = generate_client_token
        @cart = $redis.hgetall current_user.id
        render :new
      end
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

  def generate_client_token
    Braintree::ClientToken.generate
  end

end
