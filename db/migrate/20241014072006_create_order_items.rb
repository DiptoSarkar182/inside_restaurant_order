class CreateOrderItems < ActiveRecord::Migration[7.2]
  def change
    create_table :order_items do |t|
      t.references :order, null: false, foreign_key: true
      t.references :menu_item, null: false, foreign_key: true
      t.integer :quantity, null: false
      t.decimal :price, null: false, precision: 10, scale: 2
      t.timestamps
    end
  end
end
