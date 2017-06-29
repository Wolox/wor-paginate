module Wor
  module Paginate
    attr_accessor :adapters

    def initialize
      self.adapters = [Adapters::KaminariAlreadyPaginated.new,
                       Adapters::WillPaginateAlreadyPaginated.new,
                       Adapters::Kaminari.new,
                       Adapters::WillPaginate.new,
                       Adapters::ActiveModel.new,
                       Adapters::Iterable.new]
    end

    def render_paginated(content)
      render json: paginate(content)
    end

    def paginate(content)
      adapter = find_adapter_for_content(content)
      throw NoPaginationAdapter unless adapter.present?
      adapter.adapt(content, page, limit)
    end

    def find_adapter_for_content(content)
      adapters.find { |possible_adapter| possible_adapter.adapt? content }
    end

    def page
      params[:page] ? params[:page] : 1
    end

    def limit
      params[:limit] ? params[:limit] : 5
    end
  end
end
