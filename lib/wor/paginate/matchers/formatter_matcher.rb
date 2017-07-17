require_relative 'mocked_adapter'

module Wor
  module Paginate
    module Matchers
      class FormatterMatcher
        def initialize(formatter)
          @formatted_keys = formatter.new(MockedAdapter.new).format.as_json.keys
        end

        def define_matcher_for(matcher)
          # Needed to save this variable because we lose the object scope inside the block
          formatted_keys = @formatted_keys
          matcher.match { |actual_response| actual_response.keys == formatted_keys }
          matcher.failure_message do |actual_response|
            "expected that #{actual_response.keys} would be equal to #{formatted_keys}"
          end
        end
      end
    end
  end
end
