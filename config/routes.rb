Rails.application.routes.draw do
  resources :users, only: [:create]

  post '/signup', to: 'users#create'
  get '/me', to: 'users#show'
  delete '/logout', to: 'sessions#destroy'
  post '/login', to: 'sessions#create'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
