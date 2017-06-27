module Wor
  module Paginate
    module Adapters
      class ActiveModel
        def adapt?(content)
          content.respond_to? :count # no
        end

        def adapt(content, page, limit); end
      end
    end
  end
end
