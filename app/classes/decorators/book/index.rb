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

      def tag_badges
        helpers.capture do
          showable_tags.each do |tag|
            helpers.concat helpers.content_tag(:span, tag, class: "badge badge-light mr-2")
          end
        end
      end

      def showable_tags
        tags.to_a.take(5)
      end
    end
  end
end
