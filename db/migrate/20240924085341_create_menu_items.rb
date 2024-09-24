class CreateMenuItems < ActiveRecord::Migration[7.2]
  def change
    create_table :menu_items do |t|
      t.string :category, null: false
      t.string :subcategory, null: false
      t.string :title, null: false
      t.text :description, null: false
      t.decimal :price, precision: 9, scale: 2, null: false
      t.boolean :availability, default: false, null: false
      t.timestamps
    end
  end
end
