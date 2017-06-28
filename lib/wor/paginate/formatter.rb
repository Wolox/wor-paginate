module Wor
  module Paginate
    class Formatter
      def self.format(adapter)
        { items: adapter.paginated_content, count: adapter.count, total: adapter.total_count,
          page: adapter.page }
      end
    end
  end
end
