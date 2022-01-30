Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post '/key/new', to: 'sessions#create'
  resources :users, only: [:index, :show, :create, :update, :destroy]
end
