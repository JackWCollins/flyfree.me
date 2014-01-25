FlyfreeMe::Application.routes.draw do
  root 'pages#index'
  get 'register', to: "users#new"
  get 'sign_in', to: "sessions#new"
  post 'sign_in', to: "sessions#create"
  get 'sign_out', to: "sessions#destroy"
  get 'people', to: "relationships#index"

  get 'forgot_password', to: "forgot_passwords#new"
  get 'forgot_password_confirmation', to: "forgot_passwords#confirm"
  resources :forgot_passwords, only: [:create]

  resources :videos do
  	resources :reviews, only: [:create]
  end

  resources :users, except: [:destroy]
  resources :relationships, only: [:create, :destroy]

  resources :sessions, only: [:create, :destroy]
  
end
