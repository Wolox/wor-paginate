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

        def count
          paginated_content.size
        end

        def total_count
          content = @content.reorder(nil)
          content_size = content.try(:size)
          return content.to_a.size if content_size.is_a? Hash

          content.count
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
