module Wor
  module Paginate
    module Adapters
      class Adapter
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

        delegate :total_pages, to: :paginated_content
      end
    end
  end
end
