require_relative 'formatter_matcher'

RSpec::Matchers.define :be_paginated_with do |formatter|
  define_matcher_for self, formatter
end

RSpec::Matchers.define :be_paginated do
  define_matcher_for self, Wor::Paginate::Formatter
end

def define_matcher_for(matcher, formatter)
  formatter_matcher = Wor::Paginate::Matchers::FormatterMatcher.new(formatter)
  formatter_matcher.define_matcher_for(matcher)
end
