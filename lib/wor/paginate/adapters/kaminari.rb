# Used when render_paginated is called with an ActiveModel directly, with kaminari
# already required. Something like
### render_paginated DummyModel
module Wor
  module Paginate
    module Adapters
      class Kaminari
        def adapt?(content)
          content.respond_to? :page
        end

        def adapt(content, page, limit)
          to_paginate = content.page(page).per(limit)
          Wor::Paginate::Formatter.format(to_paginate,
                                          to_paginate.count,
                                          to_paginate.total_count, page)
        end
      end
    end
  end
end
