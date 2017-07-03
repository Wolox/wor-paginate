# Used when render_paginated is called with an already paginated ActiveModel with kaminari
### render_paginated DummyModel.page
module Wor
  module Paginate
    module Adapters
      class KaminariAlreadyPaginated
        attr_reader :page

        def initialize(content, page, limit)
          @content = content
          @page = page
          @limit = limit
        end

        def adapt?
          # Methods Kaminari adds to ActiveRecord relations:
          ### [:padding, :per, :total_pages, :num_pages, :current_page, :first_page?,
          ### :prev_page, :last_page?, :next_page, :out_of_range?, :total_count, :entry_name]
          %i(padding total_count num_pages current_page prev_page).all? do |method|
            @content.respond_to? method
          end
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

        def adapt(content, page, _limit)
          Wor::Paginate::Config.formatter.format(content, content.count,
                                                 content.total_count, page)
        end
      end
    end
  end
end
