# Used when render_paginated is called with an already paginated ActiveModel with kaminari
### render_paginated DummyModel.page
module Wor
  module Paginate
    module Adapters
      class KaminariAlreadyPaginated < Wor::Paginate::Adapters::BaseAdapter
        def required_methods
          # Methods Kaminari adds to ActiveRecord relations:
          ### [:padding, :per, :total_pages, :num_pages, :current_page, :first_page?,
          ### :prev_page, :last_page?, :next_page, :out_of_range?, :total_count, :entry_name]
          %i(padding total_count num_pages current_page prev_page)
        end

        def paginated_content
          @content
        end

        def count
          @content.count
        end

        def total_count
          @content.total_count
        end

        def total_pages
          @content.total_pages
        end
      end
    end
  end
end
