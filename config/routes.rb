FlyfreeMe::Application.routes.draw do
  root 'pages#index'
  get 'register', to: "users#new"
  get 'sign_in', to: "sessions#new"
  get 'sign_out', to: "sessions#destroy"

  resources :videos
  resources :users, except: [:destroy]
end
