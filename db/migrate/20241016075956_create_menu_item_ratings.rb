class CreateMenuItemRatings < ActiveRecord::Migration[7.2]
  def change
    create_table :menu_item_ratings do |t|
      t.references :user, null: false, foreign_key: true
      t.references :menu_item, null: false, foreign_key: true
      t.references :order, null: false, foreign_key: true
      t.decimal :rating, null: false, precision: 10, scale: 2
      t.timestamps
    end
  end
end
