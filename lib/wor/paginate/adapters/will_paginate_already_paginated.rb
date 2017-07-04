# Used when render_paginated is called with an already paginated ActiveModel with will_paginate
### render_paginated DummyModel.paginate(page: 1)

module Wor
  module Paginate
    module Adapters
      class WillPaginateAlreadyPaginated < Wor::Paginate::Adapters::Adapter
        attr_reader :page

        def required_methods
          # Methods will_paginate adds to ActiveRecord relations:
          ### [:current_page, :total_entries, :total_entries=, :find_last, :current_page=,
          ### :scoped, :total_pages, :next_page, :previous_page, :out_of_bounds?]
          %i(previous_page out_of_bounds? total_entries= total_pages current_page=)
        end

        def paginated_content
          @content
        end

        def count
          @content.to_a.size
        end

        def total_count
          @content.total_entries
        end
      end
    end
  end
end
