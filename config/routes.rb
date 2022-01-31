Rails.application.routes.draw do
  post '/key/new', to: 'sessions#create'
  resources :users, only: [:index, :show, :create, :update, :destroy]
  resources :teams, only: [:show, :index, :create, :update, :destroy]
end
