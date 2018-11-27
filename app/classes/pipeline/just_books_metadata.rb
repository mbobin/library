module Pipeline
  class JustBooksMetadata < Base
    URL = "https://www.justbooks.co.uk/search/?keywords=%s&currency=ROL&destination=ro&mode=isbn&lang=en&st=sh&ac=qr&submit=".freeze

    private
    attr_reader :book_data

    def execute
      return unless isbn
      return if data_already_present?

      merge_data
    end

    def data_already_present?
      @options.values_at("name", "author_names", "description").all?(&:present?)
    end

    def isbn
      @options["isbn"]
    end

    def html_data
      @html_data ||= Nokogiri::HTML(raw_data)
    end

    def raw_data
      @raw_data ||= open(search_url) rescue nil
    end

    def search_url
      URL % isbn
    end

    def book_title
      @book_title ||= html_data.at_css("span#describe-isbn-title")&.text
    end

    def authors
      @authors ||= html_data.at_css("[itemprop='author']")&.text.to_s.split(",").map(&:strip)
    end

    def book_description
      @book_description ||= html_data
        .at_css("div.description")&.text.to_s.gsub(/About the book:/, '').strip
    end

    def merge_data
      @options["name"] ||= book_title.presence
      @options["description"] ||= book_description.presence
      @options["author_names"] = authors if authors.any? && @options["author_names"].to_a.empty?
    end
  end
end
