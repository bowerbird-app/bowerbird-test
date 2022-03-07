Rails.application.routes.draw do
  
  devise_for :users, only: [:sessions]
  resources :images
  resources :tags

  root 'images#index'
  
  get 'healthcheck' => 'healthcheck#index'
end
