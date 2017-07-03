module Wor
  module Paginate
    module Adapters
      class BaseAdapter
        attr_reader :page

        def initialize(content, page, limit)
          @content = content
          @page = page
          @limit = limit
        end

        def adapt?
          required_methods.all? { |method| @content.respond_to? method }
        end

        def required_methods
          raise NotImplementedError
        end

        def paginated_content
          raise NotImplementedError
        end

        def count
          raise NotImplementedError
        end

        def total_count
          raise NotImplementedError
        end

        def total_pages
          paginated_content.total_pages
        end
      end
    end
  end
end
