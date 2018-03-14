module Decorators
  class BaseDecorator < SimpleDelegator
    RecordSet = Struct.new(:decorated_records, :active_record_collection) do
      delegate :each, :map, :to_a, to: :decorated_records
      delegate :total_count, :current_page, :limit_value, :total_pages,
        to: :active_record_collection
    end

    class RoutesHelper
      include Rails.application.routes.url_helpers
    end

    class << self
      def wrap(collection)
        collection.map { |obj| new(obj) }
      end

      def pagination_wrap(active_record_collection)
        RecordSet.new(wrap(active_record_collection), active_record_collection)
      end
    end

    def helpers
      ApplicationController.helpers
    end

    def routes
      @routes ||= RoutesHelper.new
    end
  end
end
