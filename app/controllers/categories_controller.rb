class CategoriesController < ApplicationController

  before_action :authenticate_user!
  
  def create
    @category = Category.create(category_params)
    if @category.save
      redirect_to root_path
    end
  end


  def edit
  end

  def update
  end

  def destroy
  end

  private

  def category_params
    params.require(:category).permit(:category)
  end

end