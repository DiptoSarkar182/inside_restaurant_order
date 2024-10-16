class AddTotalRatingInMenuItem < ActiveRecord::Migration[7.2]
  def change
    add_column :menu_items, :total_rating, :integer
  end
end
