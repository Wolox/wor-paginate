module Wor
  module Paginate
    module Formatters
      class PankoFormatter < Base
        def serialized_content
          Panko::ArraySerializer.new(paginated_content,
                                     each_serializer: serializer).to_a
        end
      end
    end
  end
end
