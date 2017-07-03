# Used when render_paginated is called with an iterable, something like
### render_paginated [1,2,3,4]
module Wor
  module Paginate
    module Adapters
      class Iterable < BaseAdapter
        attr_reader :page

        def required_methods
          [:to_a]
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

        def total_pages
          (total_count / @limit.to_f).ceil
        end
      end
    end
  end
end
