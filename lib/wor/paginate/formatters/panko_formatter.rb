module Wor
  module Paginate
    module Formatters
      class PankoFormatter < Base
        def serialized_content
          raise Wor::Paginate::Exceptions::DependencyError unless valid_serializer
          ActiveRecord::Base.transaction do
            Panko::ArraySerializer.new(paginated_content, each_serializer: serializer).to_a
          end
        rescue ActiveRecord::StatementInvalid
          retry
        end

        def valid_serializer
          serializer.respond_to?('_descriptor') && defined?(Panko::Serializer)
        end
      end
    end
  end
end
