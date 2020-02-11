module Wor
  module Paginate
    module Config
      DEFAULTS_CONFIGS = {
        default_per_page: 25,
        default_page: 1,
        page_param: :page,
        per_page_param: :limit,
        formatter: Wor::Paginate::Formatter,
        max_limit: 50,
        default_adapter: nil
      }.freeze

      DEFAULT_ADAPTERS = {
        kaminari_paginated: Adapters::KaminariAlreadyPaginated,
        will_paginate_paginated: Adapters::WillPaginateAlreadyPaginated,
        will_paginate: Adapters::WillPaginate,
        kaminari: Adapters::Kaminari,
        active_record: Adapters::ActiveRecord,
        enumerable: Adapters::Enumerable
      }.freeze

      @adapters = DEFAULT_ADAPTERS.values

      module_function

      DEFAULTS_CONFIGS.each do |key, value|
        define_method key do
          instance_variable_get("@#{key}") || instance_variable_set("@#{key}", value)
        end

        define_method "#{key}=" do |v|
          instance_variable_set("@#{key}", v)
        end
      end

      def add_adapter(adapter)
        @adapters << adapter
      end

      def remove_adapter(adapter)
        @adapters.delete(adapter)
      end

      def clear_adapters
        @adapters.clear
      end

      def adapters
        @adapters
      end

      # This is mostly useful for the tests
      def reset!
        DEFAULTS_CONFIGS.each { |k, v| send("#{k}=", v) }
      end

      def reset_adapters!
        @adapters = DEFAULT_ADAPTERS.values
      end
    end
  end
end
