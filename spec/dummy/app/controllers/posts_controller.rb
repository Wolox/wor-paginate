class PostsController < ApplicationController
  include Wor::Paginate

  def index
    render_paginated Post, preserve_records: true
  end
end
