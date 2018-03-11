module Pipeline
  class AddBook < Base
    private

    def execute
      book = find_by_isbn || find_by_name || create_book
      @options["book"] = book
      @options["book_id"] = book.id
    end

    def find_by_isbn
      if @options["isbn"].present?
        Book.find_by(isbn: @options["isbn"])
      end
    end

    def find_by_name
      Book.search_by_name(@options["name"])
    end

    def create_book
      Book.create(book_attributes)
    end

    def book_attributes
      {
        author_ids: @options["author_ids"],
        name: @options["name"],
        description: @options["description"],
        tags: Array(@options["tags"]),
        isbn: @options["isbn"],
      }
    end
  end
end
