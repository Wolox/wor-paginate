# Used when render_paginated is called with an iterable, something like
### render_paginated [1,2,3,4]
module Wor
  module Paginate
    module Adapters
      class Iterable
        attr_reader :page

        def initialize(content, page, limit)
          @content = content
          @page = page
          @limit = limit
        end

        def adapt?
          @content.respond_to? :to_a
        end

        def paginated_content
          return @paginated_content if @paginated_content
          content_array = @content.to_a
          @paginated_content = content_array.slice((page - 1) * @limit, @limit)
        end

        def count
          paginated_content.count
        end

        def total_count
          @content.count
        end
        
        def adapt(content, page, limit)
          content_array = content.to_a
          sliced_content = content_array.slice((page - 1) * limit, limit)
          Wor::Paginate::Config.formatter.format(sliced_content, sliced_content.count,
                                                 content_array.count, page)
        end
      end
    end
  end
end
