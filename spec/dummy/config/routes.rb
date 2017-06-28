Rails.application.routes.draw do
  resources :dummy_models, only: [:index] do
    collection do
      get 'index_array'
      get 'index_will_paginate'
      get 'index_kaminari'
    end
  end
end
