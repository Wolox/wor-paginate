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
      raise Exceptions::NoPaginationAdapter if adapter.blank?
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

    def option_limit(options)
      options[:limit].to_i unless options[:limit].nil?
    end

    def option_max_limit(options)
      options[:max_limit].to_i unless options[:max_limit].nil?
    end

    def param_limit
      params[Config.per_page_param].to_i unless params[Config.per_page_param].nil?
    end

    def limit(options)
      [
        option_max_limit(options) || Config.max_limit,
        option_limit(options) || param_limit || Config.default_per_page
      ].min
    end
  end
end
