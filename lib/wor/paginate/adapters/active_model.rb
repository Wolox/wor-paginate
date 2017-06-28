# Used when render_paginated is called with an ActiveModel directly, without a
# pagination gem like kaminari or will_paginate
### render_paginated DummyModel
module Wor
  module Paginate
    module Adapters
      class ActiveModel
        def adapt?(content)
          return false if content.is_a? Enumerable
          content.respond_to? :count # no
        end

        def adapt(content, page, limit); end
      end
    end
  end
end
