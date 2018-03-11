module Pipeline
  class Initializer < Base
    private

    def execute
      halt!("File not found") unless file_exists?

      @options
    end

    def file_exists?
      File.exists?(@options["file_path"].to_s)
    end
  end
end
