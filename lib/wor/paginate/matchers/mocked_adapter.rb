module Wor
  module Paginate
    module Matchers
      class MockedAdapter < Wor::Paginate::Adapters::Adapter
        def initialize; end

        def count
          3
        end

        def total_count
          5
        end

        def total_pages
          10
        end

        def next_page
          2
        end

        def page
          1
        end

        def paginated_content
          []
        end
      end
    end
  end
end
