module Wor
  module Paginate
    ADAPTERS = [Adapters::KaminariAlreadyPaginated,
                Adapters::WillPaginateAlreadyPaginated,
                Adapters::Kaminari,
                Adapters::WillPaginate,
                Adapters::Enumerable,
                Adapters::ActiveModel].freeze

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
      ADAPTERS.map do |possible_adapter|
        possible_adapter.new(content, page(options), limit(options))
      end.find(&:adapt?)
    end

    def page(options)
      return options[:page] if options[:page].present?
      params[Config.page_param] ? params[Config.page_param] : Config.default_page
    end

    def limit(options)
      return options[:limit] if options[:limit].present?
      params[Config.per_page_param] ? params[Config.per_page_param] : Config.default_per_page
    end
  end
end
