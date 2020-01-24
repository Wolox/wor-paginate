class DummyModelsTotalCountController < ApplicationController
  include Wor::Paginate
  include Constants

  def index
    render_paginated DummyModel, DEFAULT_TOTAL_COUNT
  end

  def index_scoped
    render_paginated DummyModel.some_scope.order(:id), DEFAULT_TOTAL_COUNT
  end

  def index_array
    render_paginated((1..28).to_a, DEFAULT_TOTAL_COUNT)
  end

  def index_with_params
    render_paginated DummyModel, DEFAULT_TOTAL_COUNT.merge(page: 3, limit: 1)
  end

  def index_with_high_limit
    render_paginated DummyModel, DEFAULT_TOTAL_COUNT.merge(limit: 125)
  end

  def index_kaminari
    render_paginated DummyModel.page(1).per(25), DEFAULT_TOTAL_COUNT
  end

  def index_will_paginate
    render_paginated DummyModel.paginate(page: 1, per_page: 25), DEFAULT_TOTAL_COUNT
  end

  def index_each_serializer
    render_paginated DummyModel,
                     DEFAULT_TOTAL_COUNT.merge(each_serializer: ReducedDummyModelSerializer)
  end

  def index_group_by
    render_paginated DummyModel.ocurrences_of_name, DEFAULT_TOTAL_COUNT
  end
end
