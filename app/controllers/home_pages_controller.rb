class HomePagesController < ApplicationController

  def index
    @menu_items = MenuItem.first(6)
    @menu_items_ratings_with_reviews = MenuItemRating.where(rating: 3..Float::INFINITY).limit(5)
  end
end
