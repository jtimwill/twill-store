# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
large_images = ["/tmp/large/dummy-665x375-Comb.jpg",
                "/tmp/large/dummy-665x375-Glass.jpg",
                "/tmp/large/dummy-665x375-Goemetry.jpg",
                "/tmp/large/dummy-665x375-Stones.jpg",
                "/tmp/large/dummy-665x375-White.jpg"]

small_images = ["/tmp/small/dummy-175x175-Bottles.jpg",
                "/tmp/small/dummy-175x175-Comb.jpg",
                "/tmp/small/dummy-175x175-DesiccationCracks.jpg",
                "/tmp/small/dummy-175x175-Glass.jpg",
                "/tmp/small/dummy-175x175-Goemetry.jpg",
                "/tmp/small/dummy-175x175-RedDots.jpg",
                "/tmp/small/dummy-175x175-Stones.jpg",
                "/tmp/small/dummy-175x175-Utrecht.jpg",
                "/tmp/small/dummy-175x175-White.jpg"]

odds = Category.create(name: "Odds")
ends = Category.create(name: "Ends")

25.times do |index|
  Product.create(
                 title: "Odd #{index + 1}",
                 description: "Just a little description of Odd #{index + 1}",
                 small_image_path: small_images.sample,
                 large_image_path1: large_images.sample,
                 large_image_path2: large_images.sample,
                 large_image_path3: large_images.sample,
                 price: rand(1999..9999),
                 category_id: odds.id,
                 category: odds.name,
                #  rating: rand(1.00..5.00)
                )
end

25.times do |index|
  Product.create(
                 title: "End #{index + 1}",
                 description: "Just a little description of End #{index + 1}",
                 small_image_path: small_images.sample,
                 large_image_path1: large_images.sample,
                 large_image_path2: large_images.sample,
                 large_image_path3: large_images.sample,
                 price: rand(1999..9999),
                 category_id: odds.id,
                 category: ends.name,
                #  rating: rand(1.00..5.00)
                )
end


ShippingOption.create(title: "Standard Shipping (4-5 business days)", cost: 799)
ShippingOption.create(title: "Free Shipping (5-8 business days)", cost: 0)


bobby = User.create(username: "Bobby Smith", password: "password", email: "bobby@example.com")
steve = User.create(username: "Steve Max", password: "password", email: "steve@example.com")

Review.create(user_id: bobby.id, product: Product.first, rating: 3, title: "review1" content: "This product is average")
Review.create(user_id: steve.id, product: Product.first, rating: 1, title: "review2" content: "This product is trash")
