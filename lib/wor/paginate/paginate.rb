module Wor
  module Paginate
    attr_accessor :adapters

    def initialize
      # TODO: Move this to a constant
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
      params[:page] ? params[:page] : 1
    end

    def limit
      params[:limit] ? params[:limit] : 5
    end
  end
end
