class Order < ApplicationRecord


  has_many :ordersproducts
  has_many :products, through: :ordersproducts

  
  

end
