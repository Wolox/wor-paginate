class DummySonsController < ApplicationController
  include Wor::Paginate

  def index
    render_paginated(DummyModel.all, each_serializer: DummyModelWithSonSerializer,
                                     include: 'dummy_model_sons.dummy_model_grand_sons')
  end

  def index_scoped
    render_paginated(DummyModel.some_scope
      .order(:id), each_serializer: DummyModelWithSonSerializer,
                   include: 'dummy_model_sons.dummy_model_grand_sons')
  end

  def index_array
    render_paginated((1..28).to_a)
  end

  def index_exception
    render_paginated 5
  end

  def index_with_params
    render_paginated(DummyModel, page: 3, limit: 1, each_serializer: DummyModelWithSonSerializer,
                                 include: 'dummy_model_sons.dummy_model_grand_sons')
  end

  def index_with_high_limit
    render_paginated(DummyModel, limit: 125, each_serializer: DummyModelWithSonSerializer,
                                 include: 'dummy_model_sons.dummy_model_grand_sons')
  end

  def index_kaminari
    render_paginated(DummyModel.page(1).per(25),
                     each_serializer: DummyModelWithSonSerializer,
                     include: 'dummy_model_sons.dummy_model_grand_sons')
  end

  def index_will_paginate
    render_paginated(DummyModel.paginate(page: 1, per_page: 25),
                     each_serializer: DummyModelWithSonSerializer,
                     include: 'dummy_model_sons.dummy_model_grand_sons')
  end

  def index_each_serializer
    render_paginated(DummyModel,
                     each_serializer: DummyModelWithSonSerializer,
                     include: 'dummy_model_sons.dummy_model_grand_sons')
  end

  def index_custom_formatter
    render_paginated(DummyModel, formatter: CustomFormatter,
                                 each_serializer: DummyModelWithSonSerializer,
                                 include: 'dummy_model_sons.dummy_model_grand_sons')
  end
end
