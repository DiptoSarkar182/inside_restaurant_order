class MenuItemRating < ApplicationRecord

  belongs_to :user
  belongs_to :menu_item
  belongs_to :order
end
