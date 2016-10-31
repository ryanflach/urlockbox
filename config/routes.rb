Rails.application.routes.draw do
  root to: 'links#index'
  resources :users, only: [:new, :create]
  resources :links, only: [:index, :create, :update]
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
