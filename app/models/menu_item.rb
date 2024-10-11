class MenuItem < ApplicationRecord

  belongs_to :category

  has_many_attached :menu_images

  has_rich_text :description
end
