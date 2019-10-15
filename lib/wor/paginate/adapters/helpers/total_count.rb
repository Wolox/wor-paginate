module Wor
  module Paginate
    module Adapters
      module Helpers
        module TotalCount
          def total_count
            content = @content.reorder(nil)
            content_size = content.size
            return content.to_a.size if content_size.is_a? Hash

            content_size
          end
        end
      end
    end
  end
end
