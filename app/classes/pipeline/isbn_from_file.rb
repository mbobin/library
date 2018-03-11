module Pipeline
  class IsbnFromFile < Base
    private

    def execute
      return if @options["isbn"]

      isbn = ruby_isbn || tika_isbn
      @options.merge!("isbn" => isbn) if isbn

      @options
    end

    def ruby_isbn
      ISBNExtractor::Directory::PureRubyDirectory.isbn(@options["file_path"])
    end

    def tika_isbn
      ISBNExtractor::Directory::TikaDirectory.isbn(@options["file_path"])
    end
  end
end
