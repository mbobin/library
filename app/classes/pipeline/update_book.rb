module Pipeline
  class UpdateBook < Base
    private

    def execute
      book = find_book
      book.update!(book_attributes)
      @options["book"] = book
    end

    def find_book
      Book.find(@options["book_id"])
    end

    def book_attributes
      {
        author_ids: @options["author_ids"],
        name: @options["name"],
        description: @options["description"],
        tags: Array(@options["tags"]),
        isbn: @options["isbn"],
      }.select { |_key, value| value.present? }
    end
  end
end
