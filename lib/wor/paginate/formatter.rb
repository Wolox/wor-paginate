module Wor
  module Paginate
    class Formatter
      attr_accessor :adapter, :content, :formatter, :options

      def initialize(adapter, options = {})
        self.adapter = adapter
        self.options = options
      end

      def format
        { page: serialized_content, count: count, total_pages: total_pages,
          total_count: total_count, current_page: current_page }
      end

      protected

      def count
        adapter.count
      end

      def total_count
        adapter.total_count
      end

      def total_pages
        adapter.total_pages
      end

      def current_page
        adapter.page.to_i
      end

      def paginated_content
        @content ||= adapter.paginated_content
      end

      def serialized_content
        return paginated_content.map(&:as_json) unless serializer.present?
        paginated_content.map { |item| serializer.new(item) }
      end

      def serializer
        options[:each_serializer]
      end
    end
  end
end
