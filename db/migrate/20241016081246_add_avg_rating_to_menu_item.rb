class AddAvgRatingToMenuItem < ActiveRecord::Migration[7.2]
  def change
    add_column :menu_items, :avg_rating, :decimal, precision: 10, scale: 2
  end
end
