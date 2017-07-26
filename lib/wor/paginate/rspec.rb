class MockedAdapter < Wor::Paginate::Adapters::Base
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

RSpec::Matchers.define :be_paginated do
  match do |actual_response|
    formatter = @custom_formatter || Wor::Paginate::Formatter
    @formatted_keys = formatter.new(MockedAdapter.new).format.as_json.keys
    actual_response.keys == @formatted_keys
  end

  chain :with do |custom_formatter|
    @custom_formatter = custom_formatter
  end

  failure_message do |actual_response|
    "expected that #{actual_response} to be paginated with keys #{@formatted_keys}"
  end

  failure_message_when_negated do |actual_response|
    "expected that #{actual_response} not to be paginated with keys #{@formatted_keys}"
  end
end
