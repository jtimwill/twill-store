Fabricator(:product) do
  title { Faker::Lorem.words(5).join(" ") }
  description { Faker::Lorem.paragraph(2) }
  category { Faker::Lorem.words(1) }
end
