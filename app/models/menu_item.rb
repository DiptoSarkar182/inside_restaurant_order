class MenuItem < ApplicationRecord

  def self.ransackable_attributes(auth_object = nil)
    ["title"]
  end

  belongs_to :category

  has_many_attached :menu_images
  has_many :order_items

  has_rich_text :description
end
