module Wor
  module Paginate
    def render_paginated(content)
      render json: format_content(paginate(content))
    end

    def paginate(content)
      content.page(page).per(limit)
    end

    def format_content(content)
      { items: content,
        count: content.count,
        total: content.total_count,
        page: page }
    end

    def page
      params[:page] ? params[:page] : 0
    end

    def limit
      params[:limit] ? params[:limit] : 5
    end
  end
end
