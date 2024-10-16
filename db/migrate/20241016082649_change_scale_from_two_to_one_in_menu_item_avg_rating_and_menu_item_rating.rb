class ChangeScaleFromTwoToOneInMenuItemAvgRatingAndMenuItemRating < ActiveRecord::Migration[7.2]
  def change
    change_column :menu_items, :avg_rating, :decimal, precision: 10, scale: 1
    change_column :menu_item_ratings, :rating, :decimal, precision: 10, scale: 1
  end
end
