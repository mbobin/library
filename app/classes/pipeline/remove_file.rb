module Pipeline
  class RemoveFile < Base
    private

    def execute
      remove_file if file_exists?

      @options
    end

    def file_exists?
      File.exists?(@options["file_path"].to_s)
    end

    def remove_file
      FileUtils.mv(@options["file_path"].to_s, backup_path)
    end

    def backup_path
      "/media/marius/storage/books-bkp/"
    end
  end
end
