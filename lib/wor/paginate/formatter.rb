module Wor
  module Paginate
    class Formatter
      attr_accessor :adapter, :content, :formatter, :options

      def initialize(adapter, options = {})
        @adapter = adapter
        @options = options
      end

      def format
        {
          page: serialized_content,
          count: count,
          total_pages: total_pages,
          total_count: total_count,
          current_page: current_page,
          next_page: next_page
        }
      end

      protected

      delegate :count, :total_count, :total_pages, :next_page, to: :adapter

      def current_page
        adapter.page.to_i
      end

      def paginated_content
        @content ||= adapter.paginated_content
      end

      def serialized_content
        return paginated_content.as_json unless serializer.present?
        paginated_content.map { |item| serializer.new(item) }
      end

      def serializer
        options[:each_serializer]
      end
    end
  end
end
