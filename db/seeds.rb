YEARS_RANGE = (2010..2020).to_a

100.times do |count|
  Book.create({
    author_name:      "#{count} Original Name - #{Faker::Book.author}",
    author_pen_name:  "#{count} Pen Name - #{Faker::Book.author}",
    book_genre:       "#{count} Genre - #{Faker::Book.genre}",
    book_original_language: "#{count} Language - #{Faker::Number.between(from: 1, to: 10)}",
    book_publishing_year: "#{count} Year - #{YEARS_RANGE.sample}",
    book_rating:      "#{count} Rating - #{Faker::Number.between(from: 1, to: 10)}",
    book_title:       "#{count} Title - #{Faker::Book.title}",
    publisher_name:   "#{count} Publisher - #{Faker::Book.publisher}",
    author_country_of_origin: "#{count} Country - #{Faker::WorldCup.team}",
  })
end

puts '100 books created'