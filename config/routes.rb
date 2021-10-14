Rails.application.routes.draw do
  root 'pages#index'

  get 'unauthorised' => 'pages#unauthorised'
  #Users routes
  resources :users do
    resources :transactions
    resources :accounts 
  end

  #Session routes
  get '/login', to: 'sessions#login'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
