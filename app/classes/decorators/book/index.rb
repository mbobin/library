module Decorators
  module Book
    class Index < BaseDecorator
      def title
        helpers.link_to(name, routes.book_path(id))
      end

      def author_names
        authors.map(&:name).join(", ")
      end

      def summarization
        description.to_s.truncate(500)
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
            helpers.concat download_document_link(document, version)
          end
        end
      end

      def tag_badges
        helpers.capture do
          tags.each do |tag|
            helpers.concat helpers.content_tag(:span, tag, class: "badge badge-light mr-2")
          end
        end
      end

      private

      def document_link(document)
        helpers.link_to(routes.document_path(document), class: "mr-2") do
          helpers.octicon("file-pdf", fill: "currentcolor")
        end
      end

      def download_document_link(document, version)
        helpers.link_to(routes.download_document_path(document), title: version.book_type, class: "mr-2") do
          helpers.octicon("cloud-download", fill: "currentcolor")
        end
      end

      def each_pdf_document
        pdf_versions.each do |version|
          version.documents.each do |document|
            yield(document)
          end
        end
      end

      def each_downloadable_document
        downloadable_versions.each do |version|
          version.documents.each do |document|
            yield(document, version)
          end
        end
      end
    end
  end
end
