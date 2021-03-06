module Wor
  module Paginate
    module Formatters
      class AmsFormatter < Base
        include ActiveSupport::Callbacks
        define_callbacks :raise_dependency_error
        set_callback :raise_dependency_error, :before, :serialized_content, unless: :ams_defined?

        def serialized_content
          return serializable_resource.new(paginated_content).as_json unless serializer.present?
          raise_dependency_error unless serializer.respond_to?('_attributes_data')
          paginated_content.map { |item| serializer.new(item, options) }
        end

        private

        def serializable_resource
          ActiveModelSerializers::SerializableResource
        end

        def ams_defined?
          defined? serializable_resource
        end

        def raise_dependency_error
          raise Wor::Paginate::Exceptions::DependencyError
        end
      end
    end
  end
end
