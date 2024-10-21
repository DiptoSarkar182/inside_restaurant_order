class AddReviewsInMenuItemRatings < ActiveRecord::Migration[7.2]
  def change
    add_column :menu_item_ratings, :review, :string
  end
end
