module Pipeline
  class AddVersion < Base
    private

    def execute
      version = create_version
      @options["version"] = version
      @options["version_id"] = version.id
    end

    def create_version
      Version.create(version_attributes)
    end

    def version_attributes
      {
        book_id: @options["book_id"],
        book_type: fetch_type,
        published_at: @options["published_at"],
      }
    end

    def fetch_type
      long_type = Marcel::MimeType.for(identifiable_chunk, name: @options["file_path"])
      Mime::Type.lookup(long_type).symbol
    end

    def identifiable_chunk
      File.read(@options["file_path"], 4.kilobytes)
    end
  end
end
