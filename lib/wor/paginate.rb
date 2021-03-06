require_relative 'paginate/adapters/base'
require_relative 'paginate/adapters/active_record'
require_relative 'paginate/adapters/enumerable'
require_relative 'paginate/adapters/kaminari'
require_relative 'paginate/adapters/will_paginate'
require_relative 'paginate/adapters/kaminari_already_paginated'
require_relative 'paginate/adapters/will_paginate_already_paginated'
require_relative 'paginate/exceptions/dependency_error'
require_relative 'paginate/exceptions/no_pagination_adapter'
require_relative 'paginate/exceptions/invalid_page_number'
require_relative 'paginate/exceptions/invalid_limit_number'
require_relative 'paginate/formatters/base'
require_relative 'paginate/formatters/panko_formatter'
require_relative 'paginate/formatters/ams_formatter'
require_relative 'paginate/config'
require_relative 'paginate/paginate'

module Wor
  module Paginate
    def self.configure
      yield Config

      return if Config.adapters.any? || Config.default_adapter.present?

      raise Exceptions::NoPaginationAdapter
    end
  end
end
