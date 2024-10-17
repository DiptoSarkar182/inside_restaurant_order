class Category < ApplicationRecord

  # ransack search parameter
  def self.ransackable_attributes(auth_object = nil)
    ["title"]
  end

  validates :title, presence: true
  validates :subtitle, presence: true

  has_one_attached :category_image

  has_many :menu_items, dependent: :destroy
end
