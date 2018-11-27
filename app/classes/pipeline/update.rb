module Pipeline
  class Update
    def self.call(options)
      options = Pipeline::IsbnMetadata.call(options)
      options = Pipeline::GoodReadsMetadata.call(options)
      options = Pipeline::GoogleBooksMetadata.call(options)
      options = Pipeline::JustBooksMetadata.call(options)
      options = Pipeline::AddAuthors.call(options)
      options = Pipeline::UpdateBook.call(options)
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
