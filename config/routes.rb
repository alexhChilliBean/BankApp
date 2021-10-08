Rails.application.routes.draw do
  root 'pages#index'

  #Users routes
  resources :users, only: [:new, :create, :edit, :update, :show, :destroy]

  #Session routes
  get '/login', to: 'sessions#login'
  post '/login', to: 'sessions#create'
  post '/logout', to: 'sessions#destroy'
  get '/logout', to: 'sessions#destroy'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
