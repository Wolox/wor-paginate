require_relative 'paginate/adapters/active_model'
require_relative 'paginate/adapters/iterable'
require_relative 'paginate/adapters/kaminari'
require_relative 'paginate/adapters/will_paginate'
require_relative 'paginate/adapters/kaminari_already_paginated'
require_relative 'paginate/adapters/will_paginate_already_paginated'
require_relative 'paginate/exceptions/no_pagination_adapter'
require_relative 'paginate/formatter'
require_relative 'paginate/config'
require_relative 'paginate/paginate'

module Wor
  module Paginate
    def self.configure
      yield Config
    end
  end
end
