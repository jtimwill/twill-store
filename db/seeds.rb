# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

cars = Category.create(name: "Cars")
planes = Category.create(name: "Planes")

10.times do |index|
  Product.create(title: "Car #{index + 1}",
               description: Faker::Lorem.paragraph(2),
               small_image_path: "/tmp/family_guy.jpg",
               large_image_path: "http://dummyimage.com/665x375/000000/00a2ff",
               category: cars)
end

10.times do |index|
  Product.create(title: "Plane #{index + 1}",
               description: Faker::Lorem.paragraph(2),
               small_image_path: "/tmp/futurama.jpg",
               large_image_path: "http://dummyimage.com/665x375/000000/00a2ff",
               category: planes)
end

bobby = User.create(username: "Bobby Smith", password: "password", email: "bobby@example.com")
steve = User.create(username: "Steve Max", password: "password", email: "steve@example.com")

Review.create(user: bobby, product: Product.first, rating: 3, content: "This product is average")
Review.create(user: steve, product: Product.first, rating: 1, content: "This product is trash")
