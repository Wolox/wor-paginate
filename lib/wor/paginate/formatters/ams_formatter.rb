module Wor
  module Paginate
    module Formatters
      class AmsFormatter < Base
        def serialized_content
          super
          return paginated_content.as_json unless defined? serializable_resource
          serializable_resource.new(paginated_content).as_json
        end

        def serializable_resource
          ActiveModelSerializers::SerializableResource
        end
      end
    end
  end
end
