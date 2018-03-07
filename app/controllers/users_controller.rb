class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def cart
    @cart = $redis.hgetall current_user.id
  end



end