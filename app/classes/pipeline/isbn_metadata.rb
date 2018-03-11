require "shellwords"

module Pipeline
  class IsbnMetadata < Base
    private
    attr_reader :book_data

    def execute
      return unless isbn

      process_file
      merge_data
    end

    def isbn
      @options["isbn"]
    end

    def process_file
      output = `fetch-ebook-metadata -i #{Shellwords.escape(isbn)} -o`
      @book_data = OpenBookFormatParser.new(output)
    end

    def merge_data
      @options["name"] = book_data.title if book_data.title
      @options["author_names"] = book_data.authors if book_data.authors
      @options["description"] = book_data.description if !@options["description"] || @options["description"].empty?
      @options["published_at"] = book_data.published_at if book_data.published_at
      @options["tags"] = Array(@options["tags"]).concat(book_data.tags).uniq
    end
  end
end
