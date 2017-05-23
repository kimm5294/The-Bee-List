Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'homepage#index'
  resources :categories, only: [:index, :show]
  resources :connections, only: [:create, :destroy]
  resources :goals, only: [:show, :create]
  resources :goals_users, only: [:create, :destroy, :update]
  post 'goals_users/return_basket' => 'goals_users#return_basket'
  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:destroy, :create, :update]
  resources :users do
    get "/friends" => "users#friends"
  end

  get "/search" => 'categories#search'
  get "/friend_search" => 'users#friend_search'

  resources :conversations do
    resources :messages
  end
end
