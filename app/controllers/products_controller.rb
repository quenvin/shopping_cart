class ProductsController < ApplicationController
  
  before_action :authenticate_user!
  def index
    @products = Product.all
    @product = Product.new
    @category = Category.new
    @existing_categories = Category.all
  end

  def create
    @products = Product.create(product_params)
    if @products.save 
      redirect_to root_path
    end
  end

  def show
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      redirect_to root_path
    end
  end

  def destroy
    product = Product.find(params[:id])
    if product.destroy
      redirect_to root_path
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :filepicker_url, :description, :price)
  end

end