# Used when render_paginated is called with an ActiveRecord directly, without a
# pagination gem like kaminari or will_paginate
### render_paginated DummyModel
module Wor
  module Paginate
    module Adapters
      class ActiveRecord < Wor::Paginate::Adapters::Adapter
        attr_reader :page

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
