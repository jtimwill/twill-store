Fabricator(:review) do
  title { Faker::Lorem.words(5).join(" ") }
  rating { Faker::Number.number(6)}
  content { Faker::Lorem.paragraph}
end
