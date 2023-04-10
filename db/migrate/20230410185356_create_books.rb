class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|

      t.string :author_name
      t.string :author_pen_name
      t.string :author_country_of_origin
      t.string :publisher_name
      t.string :book_title
      t.string :book_genre
      t.string :book_publishing_year
      t.string :book_rating
      t.string :book_original_language

      t.timestamps
    end
  end
end
