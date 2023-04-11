YEARS_RANGE = (2010..2020).to_a
LANGUAGES = %w(Arabic Somali Amharic Oromo Igbo Swahili Hausa Manding Fulani Yoruba)

Book.delete_all

100.times do |count|
  Book.create({
    author_name:      "Original Name - #{Faker::Book.author}",
    author_pen_name:  "Pen Name - #{Faker::Book.author}",
    book_genre:       "Genre - #{Faker::Book.genre}",
    book_original_language: "Language - #{LANGUAGES.sample}",
    book_publishing_year: "Year - #{YEARS_RANGE.sample}",
    book_rating:      "Rating - #{Faker::Number.between(from: 1, to: 10)}",
    book_title:       "Title - #{Faker::Book.title}",
    publisher_name:   "Publisher - #{Faker::Book.publisher}",
    author_country_of_origin: "Country - #{Faker::WorldCup.team}",
  })
end

puts '100 books created'