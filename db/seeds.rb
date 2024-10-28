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
require 'open-uri'

# Create fake orders
user_ids = User.pluck(:id)
menu_item_ids = MenuItem.pluck(:id)

30.times do  # Adjust the number of orders as needed
  total_price = 0.0
  order = Order.create(
    user_id: user_ids.sample,
    status: ['pending', 'completed', 'cancelled', 'cooking'].sample,
    payment_method: ['cash', 'credit_card', 'paypal'].sample,
    total_price: 0.0,
    created_at: rand(7.days.ago.to_date..1.day.ago.to_date).to_time
    # created_at: Time.now
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


# # Create fake users
# 10.times do
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
#     locked_at: nil,
#     created_at: Time.now - rand(0..4).days,
#     updated_at: Time.now - rand(0..3).days
#
#   )
# end

# # Create fake menu item ratings
# user_ids = User.pluck(:id)
# menu_item_ids = MenuItem.pluck(:id)
# order_ids = Order.pluck(:id)
#
# menu_item_ids.each do |menu_item_id|
#   # Generate 10 random ratings between 1 and 5
#   random_ratings = Array.new(10) { Faker::Number.between(from: 1, to: 5).round(2) }
#
#   random_ratings.each do |rating|
#     MenuItemRating.create!(
#       user_id: user_ids.sample,
#       menu_item_id: menu_item_id,
#       order_id: order_ids.sample,
#       rating: rating,
#       created_at: Time.current,
#       updated_at: Time.current
#     )
#   end
#
#   # Calculate the average rating and update the avg_rating field
#   avg_rating = MenuItemRating.where(menu_item_id: menu_item_id).average(:rating).to_f.round(1)
#   MenuItem.find(menu_item_id).update(avg_rating: avg_rating)
# end
#
# # Reset avg_rating for all menu items
# MenuItem.all.each do |menu_item|
#   # Calculate the new average rating
#   avg_rating = MenuItemRating.where(menu_item_id: menu_item.id).average(:rating).to_f.round(1)
#
#   # Update the avg_rating field
#   menu_item.update(avg_rating: avg_rating)
# end


# # # Update total rating count in menu item
# MenuItem.find_each do |menu_item|
#   total_count = MenuItemRating.where(menu_item_id: menu_item.id).count
#   menu_item.update(total_rating: total_count)
# end
#
# # Update average rating of each category
# Category.find_each do |category|
#   avg_rating = MenuItem.where(category_id: category.id).average(:avg_rating)
#   avg_rating = avg_rating || 0.0
#   category.update(avg_rating: avg_rating)
# end
#
# # Update total rating count in category
# Category.find_each do |category|
#   total_count = MenuItem.where(category_id: category.id).sum(:total_rating)
#   category.update(total_rating: total_count)
# end

# create category revenue
# Category.find_each do |category|
#   total_revenue = category.menu_items.sum(:revenue) || 0.0
#   category.update(revenue: total_revenue)
# end

# # Create random orders and ratings for the past 3 days
# user_ids = User.pluck(:id)
# menu_item_ids = MenuItem.pluck(:id)
#
# 3.times do |i| # Loop over the last 3 days
#   (1..10).each do # Create 10 ratings per day
#     order = Order.create(
#       user_id: user_ids.sample,
#       status: ['pending', 'completed', 'cancelled', 'cooking'].sample,
#       payment_method: ['cash', 'credit_card', 'paypal'].sample,
#       total_price: 0.0, # For simplicity, price is not important in this case
#       created_at: i.days.ago
#     )
#
#     menu_item_id = menu_item_ids.sample
#
#     # Create a rating for a menu item on this day
#     MenuItemRating.create(
#       user_id: user_ids.sample,
#       menu_item_id: menu_item_id,
#       order_id: order.id,
#       rating: rand(1.0..5.0).round(1), # Generate a random rating between 1.0 and 5.0
#       created_at: i.days.ago
#     )
#   end
# end
#
# puts "Fake data for the last 3 days created!"

# db/seeds.rb

# Generating Fake Reviews
# MenuItemRating.find_each do |rating|
#   case rating.rating
#   when 1.0..2.0
#     rating.update(review: Faker::Restaurant.review)
#   when 2.1..3.0
#     rating.update(review: Faker::Restaurant.review)
#   when 3.1..4.0
#     rating.update(review: Faker::Restaurant.review)
#   when 4.1..5.0
#     rating.update(review: Faker::Restaurant.review)
#   end
# end
#
# puts "Reviews populated for menu item ratings."

# # Update avatar of currently registered users
# users_to_update = User.where.not(email: ['dipto@gmail.com', 'bean@gmail.com'])
#
# users_to_update.each do |user|
#   # Attach a random avatar directly
#   avatar_url = "https://picsum.photos/200/200?random=#{rand(1..1000)}" # Random image URL
#   user.avatar.attach(io: URI.open(avatar_url), filename: "avatar_#{user.id}.jpg", content_type: 'image/jpg')
# end
#
# puts "#{users_to_update.count} users' avatars updated with random images."

# Create 5 menu item for each category
# Category.find_each do |category|
#   5.times do
#     MenuItem.create!(
#       title: Faker::Food.dish, # Generate a random dish name
#       description: Faker::Food.description, # Generate a random food description
#       price: Faker::Commerce.price(range: 5.0..50.0, as_string: false), # Generate a random price
#       availability: [true, false].sample, # Randomly assign availability as true or false
#       category_id: category.id, # Associate the menu item with the current category
#       avg_rating: Faker::Number.decimal(l_digits: 1, r_digits: 1), # Generate a random average rating
#       total_rating: Faker::Number.between(from: 1, to: 100), # Random number of total ratings
#       revenue: Faker::Commerce.price(range: 100.0..1000.0, as_string: false) # Random revenue value
#     )
#   end
# end

# 5.times do
#   MenuItem.create!(
#     title: Faker::Food.dish,
#     description: Faker::Food.description,
#     price: Faker::Commerce.price(range: 5.0..50.0, as_string: false),
#     availability: [true, false].sample,
#     category_id: 21,
#     avg_rating: Faker::Number.between(from: 1.0, to: 5.0).round(1),
#     total_rating: Faker::Number.between(from: 1, to: 100),
#     revenue: Faker::Commerce.price(range: 100.0..1000.0, as_string: false)
#   )
# end