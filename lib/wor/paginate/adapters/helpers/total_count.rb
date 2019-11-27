module Wor
  module Paginate
    module Adapters
      module Helpers
        module TotalCount
          def total_count
            @content_size ||= @content.reorder(nil).size
            return @content_size.keys.size if @content_size.is_a? Hash

            @content_size
          end
        end
      end
    end
  end
end
