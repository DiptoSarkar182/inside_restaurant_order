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
  validates :availability, presence: true
  validates :description, presence: true

end
