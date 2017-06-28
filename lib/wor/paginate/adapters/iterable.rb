# Used when render_paginated is called with an iterable, something like
### render_paginated [1,2,3,4]
module Wor
  module Paginate
    module Adapters
      class Iterable
        def adapt?(content)
          content.respond_to? :to_a
        end

        def adapt(content, page, limit)
          content_array = content.to_a
          sliced_content = content_array.slice(page * limit, limit)
          Wor::Paginate::Formatter.format(sliced_content, sliced_content.count,
                                          content_array.count, page)
        end
      end
    end
  end
end
