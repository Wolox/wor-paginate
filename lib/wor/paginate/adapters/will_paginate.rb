module Wor
  module Paginate
    module Adapters
      class WillPaginate
        def adapt?(content)
          content.respond_to? :paginate
        end

        def adapt(content, page, limit)
          to_paginate = content.paginate(page: page, per_page: limit)
          Wor::Paginate::Formatter.format(to_paginate,
                                          to_paginate.to_a.size, to_paginate.count, page)
        end
      end
    end
  end
end
