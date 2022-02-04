Rails.application.routes.draw do
  post '/token/new', to: 'sessions#create'
  resources :users, only: [:index, :show, :create, :update, :destroy]
  resources :teams, only: [:show, :index, :create, :update, :destroy] do
    resources :projects, only: [:show, :index, :create, :update, :destroy] do
      resources :tasks, only: [:show, :index, :create, :update, :destroy]
    end
  end
end
