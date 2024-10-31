class MenuItem < ApplicationRecord


  # ransack search parameter
  def self.ransackable_attributes(auth_object = nil)
    ["title"]
  end

  belongs_to :category

  has_many_attached :menu_images
  has_many :order_items, dependent: :destroy
  has_many :menu_item_ratings, dependent: :destroy

  has_rich_text :description


  validates :title, presence: true
  validates :price, presence: true
  validates :description, presence: true
  validate :menu_images_size_under_limit

  private

  def menu_images_size_under_limit
    menu_images.each do |image|
      if image.byte_size > 5.megabytes
        errors.add(:menu_images, "one or more images are too large (max size is 5MB each)")
      end
    end
  end


end
