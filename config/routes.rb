Rails.application.routes.draw do
  resources :contents
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'contents#index'

  resources :healthcheck, only: [ :index ]
  resources :version, only: [ :index ]
end
