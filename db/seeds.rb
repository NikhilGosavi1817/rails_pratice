# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require Rails.root.join('lib/build/database_builder.rb')
# Build::DatabaseBuilder.run
# 20.times do |index|
    # User.create!(first_name: "Nikhil",
    #               last_name: "Gosavi",
    #               age: Faker::Number.between(from: 18, to: 65),
    #               date_of_birth: Faker::Date.birthday(min_age: 18, max_age: 65),
    #               email: "nikhil15@gmail.com",
    #               role_type: 2,
    #               password: "nikhil18")

    # User.create!(first_name: Faker::Name.first_name,
    # last_name: Faker::Name.last_name,
    # age: Faker::Number.between(from: 18, to: 65),
    # date_of_birth: Faker::Date.birthday(min_age: 18, max_age: 65),
    # email: Faker::Internet.email,
    # role_type: 2,
    # status: 2,
    # password: Faker::Internet.password(min_length: 6))
# end
# tags = [
#   "Fiction", "Science Fiction", "Mystery", "Fantasy",
#   "Romance", "History", "Biography", "Self-Help",
#   "Cooking", "Travel", "Art", "Health", "Science",
#   "Technology", "Business", "Finance", "Education",
#   "Sports", "Music", "Nature"
# ]

# tags.each { |tag_name| Tag.create(name: tag_name) }

# # Create Books and Associate Tags
# 10.times do
#   book = Book.create(
#     name: Faker::Book.name,
#     description: Faker::Lorem.paragraph(sentence_count: 3),
#     number_of_copy: 18,
#   )
#   tags.sample(rand(1..5)).each do |tag_name|
#     tag = Tag.find_by(name: tag_name)
#     book.tags << tag if tag
#   end
# end
Tag.destroy_all
tags = [
  "Fiction", "Science Fiction", "Mystery", "Fantasy",
  "Romance", "History", "Biography", "Self-Help",
  "Cooking", "Travel", "Art", "Health", "Science",
  "Technology", "Business", "Finance", "Education",
  "Sports", "Music", "Nature"
]

tags.each { |tag| Tag.create(name: tag) }
