module Pipeline
  class Convert
    def self.call(options)
      options = Pipeline::CreatePdfFile.call(options)
      options = Pipeline::Checksum.call(options)
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
