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
            helpers.concat download_document_link(document, version)
          end
        end
      end

      private

      def showable_tags
        tags.to_a.take(15)
      end

      def document_link(document)
        helpers.link_to(routes.document_path(document), class: "mr-2") do
          helpers.octicon("file-pdf", fill: "currentcolor", height: 32)
        end
      end

      def download_document_link(document, version)
        helpers.link_to(routes.download_document_path(document), title: version.book_type, class: "mr-2") do
          helpers.octicon("cloud-download", fill: "currentcolor", height: 32)
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
