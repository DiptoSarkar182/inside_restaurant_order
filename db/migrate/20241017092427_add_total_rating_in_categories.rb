class AddTotalRatingInCategories < ActiveRecord::Migration[7.2]
  def change
    add_column :categories, :total_rating, :integer
  end
end
