module Pipeline
  class AddDocument < Base
    private

    def execute
      document = create_document
      @options["document"] = document
      @options["document_id"] = document.id
    end

    def create_document
      doc = Document.create(document_attributes)
      doc.file.attach(io: File.open(@options["file_path"]), filename: SecureRandom.uuid)
      doc
    end

    def document_attributes
      {
        version_id: @options["version_id"],
        sha_hash: @options["file_digest"],
      }
    end
  end
end
