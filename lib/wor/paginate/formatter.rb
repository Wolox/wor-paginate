module Wor
  module Paginate
    class Formatter
      def format(adapter, options = {})
        { items: items(adapter.paginated_content, options[:each_serializer]),
          count: adapter.count, total: adapter.total_count, page: adapter.page }
      end

      def items(paginated_content, each_serializer)
        return paginated_content unless each_serializer.present?
        paginated_content.map { |item| each_serializer.new(item) }
      end
    end
  end
end
