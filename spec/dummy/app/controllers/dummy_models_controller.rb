class DummyModelsController < ApplicationController
  include Wor::Paginate

  def index
    render_paginated DummyModel
  end

  def index_scoped
    render_paginated DummyModel.some_scope.order(:id)
  end

  def index_array
    render_paginated((1..28).to_a)
  end

  def index_exception
    render_paginated 5
  end

  def index_with_params
    render_paginated DummyModel, page: 3, limit: 1
  end

  def index_with_high_limit
    render_paginated DummyModel, limit: 125
  end

  def index_kaminari
    render_paginated DummyModel.page(1).per(25)
  end

  def index_will_paginate
    render_paginated DummyModel.paginate(page: 1, per_page: 25)
  end

  def index_each_serializer
    render_paginated DummyModel, each_serializer: ReducedDummyModelSerializer
  end

  def index_custom_formatter
    render_paginated DummyModel, formatter: CustomFormatter
  end

  def index_group_by
    render_paginated DummyModel.ocurrences_of_name
  end

  def index_custom_adapter
    render_paginated DummyModel, adapter: CustomAdapter
  end

  def index_panko_formatter
    render_paginated DummyModel,
                     each_serializer: DummyModelWithPankoSerializer,
                     formatter: Wor::Paginate::Formatters::PankoFormatter
  end
end
