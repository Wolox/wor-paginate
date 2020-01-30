class DummyModelsWithoutGemsController < ApplicationController
  include Wor::Paginate
  include Constants

  def index
    render_paginated DummyModel
  end

  def index_scoped
    render_paginated DummyModel.some_scope
  end

  def index_total_count
    render_paginated DummyModel, DEFAULT_TOTAL_COUNT
  end

  def index_scoped_total_count
    render_paginated DummyModel.some_scope, DEFAULT_TOTAL_COUNT
  end
end
