class Product < ApplicationRecord

  has_many :ordersproducts
  has_many :orders, through: :ordersproducts

end