module Wor
  module Paginate
    module Adapters
      class Array
        def adapt?(content)
          content.respond_to? :to_a
        end

        def adapt(content, page, limit); end
      end
    end
  end
end
