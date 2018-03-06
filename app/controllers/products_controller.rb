class ProductsController < ApplicationController
  
  before_action :authenticate_user!
  def index
    @products = Product.all
  end

  def new
    @products = Product.new
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
  end

  def update
  end

  def destroy
  end

  private

  def product_params
    params.require(:product).permit(:name, :filepicker_url, :description, :price)
  end

end