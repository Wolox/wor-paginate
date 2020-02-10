module Wor
  module Paginate
    module Utils
      module PreserveModes
        module Timestamp
          def self.default_field
            :created_at
          end

          def self.last_value(query_param_value, _content, _field)
            query_param_value ? Time.parse(query_param_value) : now_timestamp
          end

          private_class_method

          def self.now_timestamp
            Time.zone.now.iso8601(10)
          end
        end

        module Id
          def self.default_field
            :id
          end

          def self.last_value(query_param_value, content, field)
            query_param_value || content.maximum(field)
          end
        end
      end
    end
  end
end
