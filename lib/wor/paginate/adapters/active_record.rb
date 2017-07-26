# Used when render_paginated is called with an ActiveRecord directly, without a
# pagination gem like kaminari or will_paginate
### render_paginated DummyModel
module Wor
  module Paginate
    module Adapters
      class ActiveRecord < Base
        attr_reader :page

        def required_methods
          %i[offset limit table_name]
        end

        def paginated_content
          @paginated_content ||= @content.offset(offset).limit(@limit)
        end

        delegate :count, to: :paginated_content

        def total_count
          @content.count
        end

        def total_pages
          (total_count.to_f / @limit.to_f).ceil
        end

        private

        def offset
          return 0 if @page.zero?
          (@page - 1) * @limit
        end
      end
    end
  end
end
