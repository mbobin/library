require "shellwords"

module Pipeline
  class FileMetadata < Base
    private
    attr_reader :book_data

    def execute
      extract
      @options["name"] = book_data.title
      @options["author_names"] = book_data.authors
      @options["description"] = book_data.description
      @options["published_at"] = book_data.published_at
      @options["isbn"] = book_data.isbn
      @options["tags"] = book_data.tags
    end

    def tempfile
      @file ||= Tempfile.new
    end

    def extract
      safe_file = Shellwords.escape(@options["file_path"])
      `ebook-meta #{safe_file} --to-opf #{tempfile.path}`
      @book_data = OpenBookFormatParser.new(tempfile.read)
    ensure
      tempfile.close
      tempfile.unlink
    end
  end
end
