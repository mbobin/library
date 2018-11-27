module Pipeline
  class GoogleBooksMetadata < Base
    NoBook = Struct.new(:isbn)

    private
    attr_reader :book_data

    def execute
      return unless isbn
      return if data_already_present?

      merge_data
    end

    def data_already_present?
      @options
        .values_at("name", "author_names", "description", "published_at")
        .all?(&:present?)
    end

    def isbn
      @options["isbn"]
    end

    def book
      @google_book ||= begin
        Booksr.search(isbn, :isbn).to_a.first || no_book
      rescue => e
        no_book
      end
    end

    def no_book
      @no_book ||= NoBook.new(isbn)
    end

    def merge_data
      @options["name"] ||= book.title
      @options["author_names"] = book.authors if @options["author_names"].to_a.empty?
      @options["description"] ||= book.description
      @options["published_at"] ||= published_date

      @options.compact!
      @options
    end

    def published_date
      Date.strptime(book.published_date, "%Y-%m") rescue nil
    end
  end
end
