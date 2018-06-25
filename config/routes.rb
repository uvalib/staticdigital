Rails.application.routes.draw do
  resources :staticdcs
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'staticdcs#index'
end
