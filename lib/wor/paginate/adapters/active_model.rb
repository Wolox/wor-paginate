# Used when render_paginated is called with an ActiveModel directly, without a
# pagination gem like kaminari or will_paginate
### render_paginated DummyModel
module Wor
  module Paginate
    module Adapters
      class ActiveModel
        attr_reader :page

        def initialize(content, page, limit)
          @content = content
          @page = page
          @limit = limit
        end

        def adapt?
          return false if @content.is_a? Enumerable
          @content.respond_to? :count # no
        end

        def paginated_content; end

        def count; end

        def total_count; end
      end
    end
  end
end
