# Used when render_paginated is called with an Enumerable, something like
### render_paginated [1,2,3,4]
module Wor
  module Paginate
    module Adapters
      class Enumerable < Base
        attr_reader :page

        def required_methods
          %i(to_a)
        end

        def paginated_content
          return @paginated_content if @paginated_content
          content_array = @content.to_a
          @paginated_content = content_array.slice((page - 1) * @limit, @limit)
        end

        delegate :count, to: :paginated_content

        def total_count
          @content.count
        end

        def total_pages
          (total_count / @limit.to_f).ceil
        end
      end
    end
  end
end
