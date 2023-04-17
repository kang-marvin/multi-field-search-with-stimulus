class BooksController < ApplicationController

  SEARCHABLE_FIELDS = [ 'author_name', 'publisher_name', 'book_genre' ]

  def index
    @searchable_fields = SEARCHABLE_FIELDS
    @table_fields = Book.column_names
    @books = Book.all
  end

end
