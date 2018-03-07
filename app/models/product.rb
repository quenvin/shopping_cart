class Product < ApplicationRecord

  has_many :ordersproducts
  has_many :orders, through: :ordersproducts
  has_many :categoriesproduct
  has_many :categories, through: :categoriesproduct

end