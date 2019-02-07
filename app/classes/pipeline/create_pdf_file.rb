module Pipeline
  class CreatePdfFile < Base
    private
    delegate :escape, to: :Shellwords

    def execute
      download_file
      convert_file
      merge_options
    ensure
      epub_file.unlink if epub_file.exist?
    end

    def convertable_document
      @options["convertable_document"]
    end

    def convert_file
      `/usr/bin/env ebook-convert #{escape(epub_file.to_s)} #{escape(pdf_file_path)}`
      raise 'Conversion Failed' unless $?.success?
    end

    def pdf_file_path
      @pdf_file ||= Rails.root.join("tmp", "#{SecureRandom.uuid}.pdf").to_s
    end

    def download_file
      IO.binwrite(epub_file, convertable_document.file.download)
    end

    def epub_file
      @epub_file ||= Rails.root.join("tmp", "#{SecureRandom.uuid}.#{extension}")
    end

    def extension
      convertable_document.version.book_type
    end

    def merge_options
      @options.merge!(
        "book_id" => convertable_document.book.id,
        "book" => convertable_document.book,
        "file_path" => pdf_file_path,
      )
    end
  end
end
