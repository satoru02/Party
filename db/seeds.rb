20.times do
  Post.create!(
    title: Faker::Movie.title,
    url: Faker::Movie.title,
    user_id: 1
  )
end