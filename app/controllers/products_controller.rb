class ProductsController < ApplicationController
  
  before_action :authenticate_user!, except: [:index, :search, :catalog]
  def index
    @products = Product.all
    repeated_codes
    respond_to do |format|
      format.html
      format.json { render json: @products }
    end
  end

  def create
    @product = Product.create(product_params)
    
      @pcat = Category.find(params[:pcat]) if params[:pcat] #index box array

    if @product.save 
      if params[:pcat]
        @pcat.each do |pc|
          Categoriesproduct.create(product: @product, category: pc)
        end
      end
      redirect_to root_path
    end
  end

  def edit
    session[:return_to] ||= request.referer #store requesting url in session hash
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
      redirect_to session.delete(:return_to) #redirect to stored session path

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
    product = Product.find(params[:id])
    flash[:notice] = product.name + " added to cart"
    redirect_to request.referrer
  end

  def remove_cart
    count = $redis.hincrby current_user.id, params[:id], -1
    if count == 0
      $redis.hdel current_user.id, params[:id]
    end
    redirect_to cart_user_path(current_user)
  end

  def search
    repeated_codes
    
    @search_params = params[:q]
    @product_search = Product.where("name ILIKE ?", "%#{@search_params}%")
  end

  def catalog
    repeated_codes
    
    @catalog_params = params[:id]
    @catalog_name = Category.find(@catalog_params)
    @catalog_search = Categoriesproduct.where(category_id: @catalog_params)
    
    catalog = []
    @catalog_search.each do |c|
      catalog << c.product_id
    end

    @catalog = Product.where(id: catalog)
  end

  private

  def product_params
    params.require(:product).permit(:name, :filepicker_url, :description, :price, :pcat)
  end

  def repeated_codes
    @product = Product.new
    @category = Category.new
    @categoriesproduct = Categoriesproduct.select(:category_id).distinct
    @existing_categories = Category.all
  end

end