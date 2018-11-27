module Pipeline
  class GoodReadsMetadata < Base
    URL = "https://www.goodreads.com/search/index.xml?key=%s&q={%s}".freeze

    private
    attr_reader :book_data

    def execute
      return unless isbn
      return if data_already_present?

      merge_data
    end

    def data_already_present?
      @options.values_at("name", "author_names").all?(&:present?)
    end

    def isbn
      @options["isbn"]
    end

    def xml_data
      @xml_data ||= Nokogiri::XML(raw_data)
    end

    def raw_data
      @raw_data ||= open(search_url) rescue nil
    end

    def search_url
      URL % [api_key, isbn]
    end

    def book_title
      xml_data.at_xpath("//title").text
    end

    def authors
      xml_data.at_xpath("//name").text.to_s.split(",").map(&:strip)
    end

    def merge_data
      @options["name"] ||= book_title if book_title
      @options["author_names"] = authors if authors.any? && @options["author_names"].to_a.empty?
    end

    def api_key
      Rails.application.credentials.good_reads_key || Rails.application.secrets.good_reads_key
    end
  end
end
