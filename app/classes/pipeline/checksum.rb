module Pipeline
  class Checksum < Base
    private

    def execute
      @options.merge!("file_digest" => file_digest)
      halt!("Document already exists") if document_exists?

      @options
    end

    def file_digest
      @file_digest ||= Digest::SHA256.file(@options["file_path"]).hexdigest
    end

    def document_exists?
      Document.where(sha_hash: file_digest).exists?
    end
  end
end
