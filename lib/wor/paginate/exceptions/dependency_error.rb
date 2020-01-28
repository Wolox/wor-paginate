module Wor
  module Paginate
    module Exceptions
      class DependencyError < StandardError
        def initialize(msg = 'Serializer dependency error')
          super(msg)
        end
      end
    end
  end
end
