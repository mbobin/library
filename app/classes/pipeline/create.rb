module Pipeline
  class Create
    def self.call(options)
      options = Pipeline::Initializer.call(options)
      options = Pipeline::Checksum.call(options)
      options = Pipeline::FileMetadata.call(options)
      options = Pipeline::IsbnFromFile.call(options)
      options = Pipeline::IsbnMetadata.call(options)
      options = Pipeline::GoodReadsMetadata.call(options)
      options = Pipeline::GoogleBooksMetadata.call(options)
      options = Pipeline::AddAuthors.call(options)
      options = Pipeline::AddBook.call(options)
      options = Pipeline::AddVersion.call(options)
      options = Pipeline::AddDocument.call(options)
      options = Pipeline::RemoveFile.call(options)
      options

    rescue => error
      options["error"] = {
        "name" => error.class.name,
        "backtrace" => error.backtrace,
        "message" => error.message
      }

    ensure
      ImportLog.create(data: options)
    end
  end
end
