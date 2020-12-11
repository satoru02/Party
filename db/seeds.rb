20.times do
  Post.create!(
    title: Faker::Movie.title,
    url: Faker::Movie.title
  )
end