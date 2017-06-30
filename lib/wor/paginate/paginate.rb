module Wor
  module Paginate
    attr_accessor :adapters

    def initialize
      self.adapters = [Adapters::KaminariAlreadyPaginated,
                       Adapters::WillPaginateAlreadyPaginated,
                       Adapters::Kaminari,
                       Adapters::WillPaginate,
                       Adapters::Iterable,
                       Adapters::ActiveModel]
    end

    def render_paginated(content)
      render json: paginate(content)
    end

    def paginate(content)
      adapter = find_adapter_for_content(content)
      raise Exceptions::NoPaginationAdapter unless adapter.present?
      Formatter.format(adapter)
    end

    def find_adapter_for_content(content)
      @adapters.map do |possible_adapter|
        possible_adapter.new(content, page, limit)
      end.find(&:adapt?)
    end

    def page
      params[Config.page_param] ? params[Config.page_param] : Config.default_page
    end

    def limit
      params[Config.per_page_param] ? params[Config.per_page_param] : Config.default_per_page
    end
  end
end
