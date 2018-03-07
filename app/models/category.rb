class Category < ApplicationRecord

  has_many :categoriesproduct
  has_many :product, through: :categoriesproduct

end
