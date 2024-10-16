class AddAvgRatingDefaultZeroInMenuItem < ActiveRecord::Migration[7.2]
  def change
    change_column :menu_items, :avg_rating, :decimal, precision: 10, scale: 1, default: 0
  end
end
