module Pipeline
  class AddAuthors < Base
    private

    def execute
      authors = find_or_create_authors
      @options["authors"] = authors
      @options["author_ids"] = authors.map(&:id)
    end

    def author_names
      Array(@options["author_names"] || "Unknown")
    end

    def find_or_create_authors
      author_names.map { |name| Author.find_or_create_by(name: name) }
    end
  end
end
