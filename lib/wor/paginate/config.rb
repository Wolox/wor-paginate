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

      module_function

      DEFAULTS_CONFIGS.each do |key, value|
        define_method key do
          instance_variable_get("@#{key}") || instance_variable_set("@#{key}", value)
        end

        define_method "#{key}=" do |v|
          instance_variable_set("@#{key}", v)
        end
      end

      # This is mostly useful for the tests
      def reset!
        DEFAULTS_CONFIGS.each { |k, v| send("#{k}=", v) }
      end
    end
  end
end
