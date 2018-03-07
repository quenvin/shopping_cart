class Category < ApplicationRecord

  has_many :categoriesproduct
  has_many :products, through: :categoriesproduct

end
