class DummyModelsWithoutGemsController < ApplicationController
  include Wor::Paginate

  def index
    render_paginated DummyModel
  end

  def index_scoped
    render_paginated DummyModel.some_scope
  end
end
