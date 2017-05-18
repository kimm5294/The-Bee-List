Rails.application.routes.draw do
  root 'homepage#index'
  resources :sessions, only: [:new, :create, :destroy]
  resources :connections, only: [:create, :destroy]
  resources :users do
    only: [:destroy, :create, :update]
    get "/friends" => "users#friends"
  end

  get "/search" => 'users#search'
end
