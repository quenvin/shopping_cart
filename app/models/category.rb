class Category < ApplicationRecord

  has_many :categoriesproduct, dependent: :destroy
  has_many :products, through: :categoriesproduct

end
