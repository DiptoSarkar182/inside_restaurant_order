class MenuItem < ApplicationRecord

  # belongs_to :user

  has_many_attached :menu_images
end
