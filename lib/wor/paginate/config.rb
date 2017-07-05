module Wor
  module Paginate
    module Config
      DEFAULTS_CONFIGS = {
        default_per_page: 25,
        default_page: 1,
        page_param: :page,
        per_page_param: :per_page,
        formatter: Wor::Paginate::Formatter
      }.freeze

      module_function

      DEFAULTS_CONFIGS.each do |key, value|
        define_method key do
          instance_variable_get("@#{key}") || instance_variable_set("@#{key}", value)
        end

        define_method "#{key}=" do |_v|
          instance_variable_get("@#{key}")
        end
      end
    end
  end
end
