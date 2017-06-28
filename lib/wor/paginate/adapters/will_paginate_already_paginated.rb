# Used when render_paginated is called with an already paginated ActiveModel with will_paginate
### render_paginated DummyModel.paginate(page: 1)

module Wor
  module Paginate
    module Adapters
      class WillPaginateAlreadyPaginated
        attr_reader :page

        def initialize(content, page, limit)
          @content = content
          @page = page
          @limit = limit
        end

        def adapt?
          # Methods will_paginate adds to ActiveRecord relations:
          ### [:current_page, :total_entries, :total_entries=, :find_last, :current_page=,
          ### :scoped, :total_pages, :next_page, :previous_page, :out_of_bounds?]
          %i[previous_page out_of_bounds? total_entries=
             total_pages current_page=].all? do |method|
            @content.respond_to? method
          end
        end

        def adapt(content, page, _limit)
          Wor::Paginate::Formatter.format(content, content.to_a.size,
                                          content.total_entries, page)
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
