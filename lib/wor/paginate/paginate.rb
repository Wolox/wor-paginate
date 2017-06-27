module Wor
  module Paginate
    attr_accessor :adapters

    def initialize
      self.adapters = [Adapters::Kaminari.new, Adapters::WillPaginate.new,
                       Adapters::ActiveModel.new, Adapters::Array.new]
    end

    def render_paginated(content)
      render json: paginate(content)
    end

    def paginate(content)
      adapter = adapters.find { |possible_adapter| possible_adapter.adapt? content }
      throw "No pagination adapter for class #{content.class}" unless adapter.present?
      adapter.adapt(content, page, limit)
    end

    def page
      params[:page] ? params[:page] : 0
    end

    def limit
      params[:limit] ? params[:limit] : 5
    end
  end
end
