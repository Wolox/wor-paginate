module Wor
  module Paginate
    module Formatters
      class PankoFormatter < Base
        def serialized_content
          raise Wor::Paginate::Exceptions::DependencyError unless valid_serializer
          Panko::ArraySerializer.new(paginated_content,
                                     each_serializer: serializer).to_a
        end

        def valid_serializer
          serializer.respond_to?('_descriptor') && defined?(Panko::Serializer)
        end
      end
    end
  end
end
