require 'faker'
require 'open-uri'


puts "Seeding Specific Users..."
User.create!(
  email: 'dipto@gmail.com',
  password: '111111',
  password_confirmation: '111111',
  first_name: "Dipto",
  last_name: "Sarkar",
  date_of_birth: Faker::Date.birthday(min_age: 18, max_age: 65),
  contact_number: Faker::PhoneNumber.cell_phone,
  nationality: Faker::Nation.nationality,
  country_code: Faker::PhoneNumber.country_code,
  is_admin: true,
  created_at: Time.now - rand(0..4).days,
  updated_at: Time.now - rand(0..3).days
)

User.create!(
  email: 'bean@gmail.com',
  password: '111111',
  password_confirmation: '111111',
  first_name: "Mr.",
  last_name: "Bean",
  date_of_birth: Faker::Date.birthday(min_age: 18, max_age: 65),
  contact_number: Faker::PhoneNumber.cell_phone,
  nationality: Faker::Nation.nationality,
  country_code: Faker::PhoneNumber.country_code,
  is_admin: false,
  created_at: Time.now - rand(0..4).days,
  updated_at: Time.now - rand(0..3).days
)

# Seed Users
puts "Seeding Users..."
10.times do
  User.create!(
    email: Faker::Internet.unique.email,
    password: 'password',
    password_confirmation: 'password',
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    date_of_birth: Faker::Date.birthday(min_age: 18, max_age: 65),
    contact_number: Faker::PhoneNumber.cell_phone,
    nationality: Faker::Nation.nationality,
    country_code: Faker::PhoneNumber.country_code,
    is_admin: false,
    created_at: Time.now - rand(0..4).days,
    updated_at: Time.now - rand(0..3).days
  )
end

# Seed Categories
puts "Seeding Random Food Categories with images..."
20.times do
  category_name = Faker::Food.unique.dish
  category = Category.find_or_create_by!(title: category_name, subtitle: "#{category_name} Subtitle")
  category_image_url = "https://picsum.photos/400/300?random=#{rand(1..1000)}"
  category.category_image.attach(io: URI.open(category_image_url), filename: "category_#{category.id}.jpg", content_type: 'image/jpg')
end

# Seed Menu Items with food names, descriptions, and random images
puts "Seeding Menu Items with images..."
Category.find_each do |category|
  5.times do
    menu_item = MenuItem.create!(
      title: Faker::Food.dish,
      description: Faker::Food.description,
      price: Faker::Commerce.price(range: 5.0..50.0, as_string: false),
      availability: [true, false].sample,
      category_id: category.id,
      avg_rating: Faker::Number.decimal(l_digits: 1, r_digits: 1),
      total_rating: Faker::Number.between(from: 1, to: 100),
      revenue: Faker::Commerce.price(range: 100.0..1000.0, as_string: false)
    )

    # Attach multiple random images to the MenuItem
    3.times do
      menu_image_url = "https://picsum.photos/200/150?random=#{rand(1..1000)}"
      menu_item.menu_images.attach(io: URI.open(menu_image_url), filename: "menu_item_#{menu_item.id}_#{rand(1..1000)}.jpg", content_type: 'image/jpg')
    end
  end
end

# Seed Orders and Order Items
puts "Seeding Orders and Order Items..."
user_ids = User.pluck(:id)
menu_item_ids = MenuItem.pluck(:id)

30.times do
  total_price = 0.0
  order = Order.create(
    user_id: user_ids.sample,
    status: ['pending', 'completed', 'cancelled', 'cooking'].sample,
    payment_method: ['cash', 'credit_card', 'paypal'].sample,
    total_price: 0.0,
    created_at: rand(7.days.ago.to_date..1.day.ago.to_date).to_time
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

# Seed Menu Item Ratings and Reviews
puts "Seeding Menu Item Ratings..."
user_ids = User.pluck(:id)
menu_item_ids = MenuItem.pluck(:id)
order_ids = Order.pluck(:id)

menu_item_ids.each do |menu_item_id|
  10.times do
    rating = Faker::Number.between(from: 1.0, to: 5.0).round(1)
    review = Faker::Restaurant.review

    MenuItemRating.create!(
      user_id: user_ids.sample,
      menu_item_id: menu_item_id,
      order_id: order_ids.sample,
      rating: rating,
      review: review,
      created_at: Time.current,
      updated_at: Time.current
    )
  end
end

# Update Ratings and Revenue Aggregates
puts "Updating Menu Item and Category Aggregates..."

# Update Menu Item average and total ratings
MenuItem.find_each do |menu_item|
  avg_rating = MenuItemRating.where(menu_item_id: menu_item.id).average(:rating).to_f.round(1)
  total_rating = MenuItemRating.where(menu_item_id: menu_item.id).count
  menu_item.update(avg_rating: avg_rating, total_rating: total_rating)
end

# Update Category average ratings and revenue
Category.find_each do |category|
  avg_rating = MenuItem.where(category_id: category.id).average(:avg_rating).to_f.round(1)
  total_revenue = category.menu_items.sum(:revenue).to_f.round(2)
  total_count = MenuItem.where(category_id: category.id).sum(:total_rating)

  category.update(avg_rating: avg_rating, revenue: total_revenue, total_rating: total_count)
end

# Update Avatars for Users
puts "Updating User Avatars..."
users_to_update = User.where.not(email: ['dipto@gmail.com', 'bean@gmail.com'])

users_to_update.each do |user|
  avatar_url = "https://picsum.photos/200/200?random=#{rand(1..1000)}"
  user.avatar.attach(io: URI.open(avatar_url), filename: "avatar_#{user.id}.jpg", content_type: 'image/jpg')
end

puts "Seeding completed successfully!"
