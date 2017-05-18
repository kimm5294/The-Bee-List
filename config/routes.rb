Rails.application.routes.draw do
  root 'homepage#index'
  resources :sessions, only: [:new, :create, :destroy]
  resources :connections, only: [:create, :destroy]
  resources :users, only: [:destroy, :create, :update]
  resources :users do
    get "/friends" => "users#friends"
  end

  get "/search" => 'users#search'
end
