class Category < ApplicationRecord

  # ransack search parameter
  def self.ransackable_attributes(auth_object = nil)
    ["title"]
  end

  validates :title, presence: true
  validates :subtitle, presence: true

  has_one_attached :category_image

  has_many :menu_items, dependent: :destroy

  validate :category_image_size_under_limit

  private
  def category_image_size_under_limit
    if category_image.attached? && category_image.blob.byte_size > 5.megabytes
      category_image.purge
      errors.add(:category_image, 'is too large (max is 5MB)')
    end
  end
end
