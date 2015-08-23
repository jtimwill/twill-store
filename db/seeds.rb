# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

10.times do |index|
  Product.create(title: "Family Guy #{index + 1}",
               description: "Family Guy Info",
               small_image_path: "/tmp/family_guy.jpg",
               large_image_path: "http://dummyimage.com/665x375/000000/00a2ff",
               category: comedies)
end

10.times do |index|
  Product.create(title: "Futurama #{index + 1}",
               description: "Futurama Info",
               small_image_path: "/tmp/futurama.jpg",
               large_image_path: "http://dummyimage.com/665x375/000000/00a2ff",
               category: dramas)
end
