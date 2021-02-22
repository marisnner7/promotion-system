# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

puts 'Cleaning DB'

Promotion.destroy_all
ProductCategoryPromotion.destroy_all
ProductCategory.destroy_all
puts 'Products Categories deleted'
puts 'Deleting promotions'

puts 'Creating products categories'

product_categories = []
pc1 = ProductCategory.create!(name: 'Hospedagem', code: 'HOSP')
pc2 = ProductCategory.create!(name: 'Email', code: 'EMAIL')
pc3 = ProductCategory.create!(name: 'Cloud', code: 'CLOU')

product_categories << pc1
product_categories << pc2
product_categories << pc3

puts 'products category created'

puts 'Creating Promotions'

8.times do
  promotion = Promotion.create!(
    name: Faker::Company.name,
    description: Faker::Company.buzzword,
    code: Faker::Barcode.ean(8),
    discount_rate: rand(1..15).truncate(2),
    coupon_quantity: rand(1..20),
    expiration_date: Faker::Date.forward(days: 45),
    product_category_ids: product_categories.sample.id
  )
end

puts 'Promotions Created!'
