# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

puts 'Cleaning DB'

ProductCategory.delete_all
puts 'Products Categories deleted'
puts 'Deleting promotions'
Promotion.delete_all

puts 'Creating Promotions'
8.times do
  promotion = Promotion.create!(
    name: Faker::Company.name,
    description: Faker::Company.buzzword,
    code: Faker::Barcode.ean(8),
    discount_rate: rand(1..15).truncate(2),
    coupon_quantity: rand(1..20),
    expiration_date: Faker::Date.forward(days: 45)
  )
end
puts 'Promotions Created!'

puts 'Creating products categories'
2.times do
  promotion = ProductCategory.create!(
    name: Faker::Company.name,
    code: Faker::Barcode.ean(8),
  )
end

puts 'products category created'


