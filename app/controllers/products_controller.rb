class ProductsController < ApplicationController
  
  before_action :authenticate_user!
  def index
    @products = Product.all
    @product = Product.new
    @category = Category.new
    @existing_categories = Category.all
  end

  def create
    @product = Product.create(product_params)
    
      @pcat = Category.find(params[:pcat]) if params[:pact] #index box array

    if @product.save 
      if params[:pact]
        @pcat.each do |pc|
          Categoriesproduct.create(product: @product, category: pc)
        end
      end
      redirect_to root_path
    end
  end

  def show
  end

  def edit
    @product = Product.all.find(params[:id])
    @existing_categories = Category.all 
  end

  def update
    @product = Product.find(params[:id])
    @pcat = Category.find(params[:pcat]) if params[:pcat] != nil #index box array

    cleanse_cat = Categoriesproduct.where(product: @product)  #cleanse Categoriesproduct of existing product id
    cleanse_cat.each do |cleanse|
      cleanse.destroy
    end

    if @product.update(product_params)  
      if @pcat != nil
        @pcat.each do |pc|
          Categoriesproduct.create(product: @product, category: pc)
        end
      end
      redirect_to root_path
    end
  end

  def destroy
    product = Product.find(params[:id])
    if product.destroy
      redirect_to root_path
    end
  end

  def add_cart
    $redis.hincrby current_user.id, params[:id], 1
    redirect_to cart_user_path(current_user)
  end

  def remove_cart
    count = $redis.hincrby current_user.id, params[:id], -1
    if count == 0
      $redis.hdel current_user.id, params[:id]
    end
    redirect_to cart_user_path(current_user)
  end

  def search

  end

  private

  def product_params
    params.require(:product).permit(:name, :filepicker_url, :description, :price, :pcat)
  end

end