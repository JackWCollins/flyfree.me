FlyfreeMe::Application.routes.draw do
  root 'pages#index'

  resources :videos
end
