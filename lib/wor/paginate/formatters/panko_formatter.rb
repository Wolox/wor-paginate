module Wor
  module Paginate
    module Formatters
      class PankoFormatter < Base
        def serialized_content
          serilize_with_panko(serializer)
        end

        def serilize_with_panko(seriaizer)
          Panko::ArraySerializer.new(paginated_content,
            each_serializer: serializer).as_json['subjects']
        end
      end
    end
  end
end
