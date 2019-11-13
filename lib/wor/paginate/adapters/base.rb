module Wor
  module Paginate
    module Adapters
      class Base
        attr_reader :page

        def initialize(content, page, limit)
          @content = content
          @page = page.to_i
          @limit = limit.to_i
          raise Wor::Paginate::Exceptions::InvalidPageNumber if @page <= 0
          raise Wor::Paginate::Exceptions::InvalidLimitNumber if @limit <= 0
        end

        def adapt?
          required_methods.all? { |method| @content.respond_to? method }
        end

        %i[required_methods paginated_content count total_count next_page].each do |method|
          define_method(method) { raise NotImplementedError }
        end

        delegate :total_pages, to: :paginated_content

        def next_page
          return nil if page >= total_pages

          page + 1
        end

        def previous_page
          return nil if page == 1

          page - 1
        end
      end
    end
  end
end
