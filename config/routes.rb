FlyfreeMe::Application.routes.draw do
  root 'pages#index'

  resources :videos
  resources :users, except: [:destroy]
end
