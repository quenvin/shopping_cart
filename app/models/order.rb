class Order < ApplicationRecord

  belongs_to :user
  has_many :transactions
  has_many :ordersproducts
  has_many :products, throught: :ordersproducts

end
