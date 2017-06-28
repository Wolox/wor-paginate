# Methods will_paginate adds to ActiveRecord relations:
### [:current_page, :total_entries, :total_entries=, :find_last, :current_page=,
### :scoped, :total_pages, :next_page, :previous_page, :out_of_bounds?]
module Wor
  module Paginate
    module Adapters
      class WillPaginateAlreadyPaginated
        def adapt?(content)
          %i[previous_page out_of_bounds? total_entries=
             total_pages current_page=].all? do |method|
            content.respond_to? method
          end
        end

        def adapt(content, page, _limit)
          Wor::Paginate::Formatter.format(content, content.count,
                                          content.total_count, page)
        end
      end
    end
  end
end
