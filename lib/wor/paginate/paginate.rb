module Wor
  module Paginate
    # The order of this array is important!
    # In a future release we'll provide an interface to manipulate it
    ADAPTERS = [
      Adapters::KaminariAlreadyPaginated,
      Adapters::WillPaginateAlreadyPaginated,
      Adapters::WillPaginate,
      Adapters::Kaminari,
      Adapters::ActiveRecord,
      Adapters::Enumerable
    ].freeze

    def render_paginated(content, options = {})
      render json: paginate(content, options)
    end

    def paginate(content, options = {})
      adapter = find_adapter_for_content(content, options)
      raise Exceptions::NoPaginationAdapter unless adapter.present?
      formatter_class(options).new(adapter, options).format
    end

    def formatter_class(options)
      options[:formatter].presence || Formatter
    end

    def find_adapter_for_content(content, options)
      ADAPTERS.map { |adapter| adapter.new(content, page(options), limit(options)) }
              .find(&:adapt?)
    end

    def page(options)
      options[:page] || params[Config.page_param] || Config.default_page
    end

    def limit(options)
      [
        Config.max_limit,
        options[:limit] || params[Config.per_page_param] || Config.default_per_page
      ].min
    end
  end
end
