# Used when render_paginated is called with an already paginated ActiveModel with will_paginate
### render_paginated DummyModel.paginate(page: 1)

module Wor
  module Paginate
    module Adapters
      class WillPaginateAlreadyPaginated < Base
        attr_reader :page

        def required_methods
          # Methods will_paginate adds to ActiveRecord relations:
          ### [:current_page, :total_entries, :total_entries=, :find_last, :current_page=,
          ### :scoped, :total_pages, :next_page, :previous_page, :out_of_bounds?]
          %i(previous_page out_of_bounds? total_entries= total_pages current_page=)
        end

        def paginated_content
          @paginated_content ||= @content.limit(nil).offset(0)
                                         .paginate(page: @page, per_page: @limit)
        end

        def count
          paginated_content.to_a.size
        end

        def total_count
          paginated_content.total_entries
        end
      end
    end
  end
end
