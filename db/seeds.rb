# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'faker'

# Sample data
# user_ids = User.pluck(:id)
menu_item_ids = MenuItem.pluck(:id)


10.times do  # Adjust the number of orders as needed
  total_price = 0.0
  order = Order.create(
    user_id: 2,
    status: ['pending', 'completed', 'cancelled', 'cooking'].sample,
    payment_method: ['cash', 'credit_card', 'paypal'].sample,
    total_price: 0.0
  )


  rand(1..5).times do
    menu_item_id = menu_item_ids.sample
    quantity = rand(1..3)
    price = MenuItem.find(menu_item_id).price


    OrderItem.create(
      order_id: order.id,
      menu_item_id: menu_item_id,
      quantity: quantity,
      price: price
    )

    total_price += price * quantity
  end


  order.update(total_price: total_price)
end
