class CreateOrders < ActiveRecord::Migration[7.2]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.string :status, null: false, default: "pending"
      t.decimal :total_price, precision: 10, scale: 2, null: false
      t.string :payment_method, null: false, default: "cash"
      t.timestamps
    end
  end
end
