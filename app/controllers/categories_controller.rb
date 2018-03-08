class CategoriesController < ApplicationController

  before_action :authenticate_user!
  
  def create
    @category = Category.create(category_params)
    if @category.save
      redirect_to root_path
    end
  end

  def show
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      redirect_to root_path
    end
  end

  def destroy
    category = Category.find(params[:id])
    if category.destroy
      redirect_to root_path
    end
  end

  private

  def category_params
    params.require(:category).permit(:category)
  end

end