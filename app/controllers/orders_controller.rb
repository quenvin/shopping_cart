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
      redirect_to root_url, notice: "Congraulations! Your transaction has been successfully!"
    else
      flash[:alert] = "Something went wrong while processing your transaction. Please try again!"
      gon.client_token = generate_client_token
      @cart = $redis.hgetall current_user.id
      render :new
    end
  end

  private

  def generate_client_token
    Braintree::ClientToken.generate
  end



end
