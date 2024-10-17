class AddRevenueInCategory < ActiveRecord::Migration[7.2]
  def change
    add_column :categories, :revenue, :decimal, precision: 10, scale: 2, default: 0.0
  end
end
