module Wor
  module Paginate
    class Formatter
      def self.format(content, count, total_count, page)
        { items: content, count: count, total: total_count, page: page }
      end
    end
  end
end
