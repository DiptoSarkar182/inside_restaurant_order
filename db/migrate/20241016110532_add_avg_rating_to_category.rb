class AddAvgRatingToCategory < ActiveRecord::Migration[7.2]
  def change
    add_column :categories, :avg_rating, :decimal, precision: 10, scale: 1, default: 0
  end
end
