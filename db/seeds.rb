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

# Create fake orders
# user_ids = User.pluck(:id)
# menu_item_ids = MenuItem.pluck(:id)
#
#
# 30.times do  # Adjust the number of orders as needed
#   total_price = 0.0
#   order = Order.create(
#     user_id: 2,
#     status: ['pending', 'completed', 'cancelled', 'cooking'].sample,
#     payment_method: ['cash', 'credit_card', 'paypal'].sample,
#     total_price: 0.0
#   )
#
#
#   rand(1..5).times do
#     menu_item_id = menu_item_ids.sample
#     quantity = rand(1..3)
#     price = MenuItem.find(menu_item_id).price
#
#
#     OrderItem.create(
#       order_id: order.id,
#       menu_item_id: menu_item_id,
#       quantity: quantity,
#       price: price
#     )
#
#     total_price += price * quantity
#   end
#
#
#   order.update(total_price: total_price)
# end

# Create fake users
# 30.times do
#   User.create!(
#     email: Faker::Internet.unique.email,
#     password: 'password',
#     password_confirmation: 'password',
#     first_name: Faker::Name.first_name,
#     last_name: Faker::Name.last_name,
#     date_of_birth: Faker::Date.birthday(min_age: 18, max_age: 65),
#     contact_number: Faker::PhoneNumber.cell_phone,
#     nationality: Faker::Nation.nationality,
#     country_code: Faker::PhoneNumber.country_code,
#     is_admin: false, # Randomly assign admin status
#     # The following fields are optional and can be left nil
#     reset_password_token: nil,
#     reset_password_sent_at: nil,
#     remember_created_at: nil,
#     confirmation_token: nil,
#     confirmed_at: nil,
#     confirmation_sent_at: nil,
#     unconfirmed_email: nil,
#     failed_attempts: 0,
#     unlock_token: nil,
#     locked_at: nil
#   )
# end

# Create fake ratings
user_ids = User.pluck(:id)
menu_item_ids = MenuItem.pluck(:id)
order_ids = Order.pluck(:id)

# Create ratings and update avg_rating for each menu item
menu_item_ids.each do |menu_item_id|
  # Generate random ratings for this menu item
  random_ratings = Array.new(10) { Faker::Number.between(from: 1, to: 5).round(2) }

  # Create menu item ratings
  random_ratings.each do |rating|
    MenuItemRating.create!(
      user_id: user_ids.sample,
      menu_item_id: menu_item_id,
      order_id: order_ids.sample,
      rating: rating,
      created_at: Time.current,
      updated_at: Time.current
    )
  end

  # Calculate the average rating for the menu item
  avg_rating = MenuItemRating.where(menu_item_id: menu_item_id).average(:rating)

  # Update the avg_rating in the menu_items table
  MenuItem.find(menu_item_id).update(avg_rating: avg_rating)
end

