class PostsController < ApplicationController
  include Wor::Paginate

  def index
    render_paginated Post, preserve_records: true
  end

  def index_by_id
    render_paginated Post, preserve_records: { by: :id }
  end
end
