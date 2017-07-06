# Used when render_paginated is called with an ActiveRecord directly, without a
# pagination gem like kaminari or will_paginate
### render_paginated DummyModel
module Wor
  module Paginate
    module Adapters
      class ActiveRecord < Wor::Paginate::Adapters::Adapter
        attr_reader :page

        def required_methods
          %i(offset limit table_name)
        end

        def paginated_content
          @paginated_content ||= @content.offset(offset).limit(@limit)
        end

        def count
          paginated_content.count
        end

        def total_count
          @content.count
        end

        def total_pages
          (total_count.to_f / @limit.to_f).ceil
        end

        private

        def offset
          raise Wor::Paginate::Exceptions::InvalidPageNumber if @page.to_i.negative?
          ((@page.to_i - 1).negative? ? 0 : @page.to_i - 1) * @limit
        end
      end
    end
  end
end
