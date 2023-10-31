require 'faker'

# Create 3 items for Argentina
3.times do
  Item.create!(
    name: Faker::Address.street_name,
    image: "hause-example.png",
    city: 'Buenos Aires',
    description: Faker::Lorem.sentence,
    price: rand(100.0..500.0).round(2)
  )
end

# Create 3 items for Chile
3.times do
  Item.create!(
    name: Faker::Address.street_name,
    image: "hause-example.png",
    city: 'Santiago',
    description: Faker::Lorem.sentence,
    price: rand(100.0..500.0).round(2)
  )
end

# Create 3 items for Venezuela
3.times do
  Item.create!(
    name: Faker::Address.street_name,
    image: "hause-example.png",
    city: 'Caracas',
    description: Faker::Lorem.sentence,
    price: rand(100.0..500.0).round(2)
  )
end
