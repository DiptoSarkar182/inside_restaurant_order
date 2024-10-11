class Category < ApplicationRecord

  has_one_attached :category_image

  has_many :menu_items, dependent: :destroy
end
