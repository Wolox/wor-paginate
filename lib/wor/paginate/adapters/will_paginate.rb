require_relative 'helpers/total_count'

# Used when render_paginated is called with an ActiveModel directly, with will_paginate
# already required. Something like
### render_paginated DummyModel
module Wor
  module Paginate
    module Adapters
      class WillPaginate < Base
        include Helpers::TotalCount

        attr_reader :page

        def required_methods
          %i[paginate]
        end

        def paginated_content
          @paginated_content ||= @content.paginate(page: @page, per_page: @limit)
        end

        def count
          paginated_content.to_a.size
        end

        delegate :total_pages, :next_page, to: :paginated_content
      end
    end
  end
end
