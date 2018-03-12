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
      File.unlink(@options["file_path"].to_s)
    end
  end
end
