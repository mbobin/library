module Decorators
  module Book
    class Show < Index
      def title
        name
      end

      def summarization
        helpers.capture do
          description.to_s.split("\n").each do |text|
            helpers.concat helpers.content_tag(:p, text)
          end
        end
      end

      def link_to_pdf_versions
        helpers.capture do
          each_pdf_document do |document|
            helpers.concat document_link(document)
          end
        end
      end

      def link_to_downloadable_versions
        helpers.capture do
          each_downloadable_document do |document, version|
            helpers.concat version_group_links(document, version)
          end
        end
      end

      private

      def showable_tags
        tags.to_a.take(15)
      end

      def document_link(document)
        helpers.content_tag(:div, class: "btn-group mr-2", role: "group") do
          helpers.link_to(routes.document_path(document), class: "btn btn-secondary") do
            helpers.octicon("file-pdf", fill: "currentcolor", height: 32)
          end
        end
      end

      def version_group_links(document, version)
        helpers.content_tag(:div, class: "btn-group mr-2", role: "group") do
          helpers.concat download_document_link(document, version)
          helpers.concat convert_document_link(document) if show_conversion_links?
        end
      end

      def download_document_link(document, version)
        helpers.link_to(routes.download_document_path(document), title: version.book_type, class: "btn btn-secondary") do
          helpers.octicon("cloud-download", fill: "currentcolor", height: 32)
        end
      end

      def convert_document_link(document)
        helpers.link_to(routes.convert_document_path(document), title: "Convert to PDF", class: "btn btn-secondary", method: :post) do
          helpers.octicon("file-pdf", fill: "currentcolor", height: 32)
        end
      end

      def each_pdf_document
        pdf_versions.includes(:documents).find_each do |version|
          version.documents.each do |document|
            yield(document)
          end
        end
      end

      def each_downloadable_document
        downloadable_versions.includes(:documents).find_each do |version|
          version.documents.each do |document|
            yield(document, version)
          end
        end
      end

      def show_conversion_links?
        pdf_versions.none?
      end
    end
  end
end
