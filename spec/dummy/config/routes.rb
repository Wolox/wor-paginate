Rails.application.routes.draw do
  resources :dummy_models_without_gems, only: [:index] do
    collection do
      get :index_paginated
    end
  end
  resources :dummy_models, only: [:index] do
    collection do
      get 'index_array'
      get 'index_will_paginate'
      get 'index_kaminari'
      get 'index_exception'
      get 'index_scoped'
      get 'index_with_params'
      get 'index_with_high_limit'
      get 'index_each_serializer'
      get 'index_custom_formatter'
      get 'index_group_by'
    end
  end

  resources :dummy_sons, only: [:index] do
    collection do
      get 'index_array'
      get 'index_will_paginate'
      get 'index_kaminari'
      get 'index_exception'
      get 'index_scoped'
      get 'index_with_params'
      get 'index_with_high_limit'
      get 'index_each_serializer'
      get 'index_custom_formatter'
    end
  end
end
