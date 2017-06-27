Rails.application.routes.draw do
  resources :dummy_models, only: [:index]
end
