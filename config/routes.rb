FlyfreeMe::Application.routes.draw do
  root 'pages#index'
  get 'register', to: "users#new"
  get 'sign_in', to: "sessions#new"
  post 'sign_in', to: "sessions#create"
  get 'sign_out', to: "sessions#destroy"

  resources :videos do
  	resources :reviews, only: [:create]
  end

  resources :users, except: [:destroy]

  resources :sessions, only: [:create, :destroy]
  
end
