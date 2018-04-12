class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def cart
    @categoriesproduct = Categoriesproduct.select(:category_id).distinct
    @existing_categories = Category.all
    @cart = $redis.hgetall current_user.id
  end

  def destroy
    redirect_to root_path if current_user.destroy
  end

end