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
    end
  end
end
