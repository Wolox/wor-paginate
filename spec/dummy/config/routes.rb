Rails.application.routes.draw do
  resources :dummies, only: [:index]
end
