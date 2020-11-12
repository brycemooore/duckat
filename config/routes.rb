Rails.application.routes.draw do
  resources :users, only: [:show, :new, :create, :edit, :update, :destroy]
  resources :items
  resources :bids, only: [:index, :show, :new, :create, :destroy]
  
  patch '/users/:id/balance', to: 'users#update_balance', as: 'update_balance'
  get '/users/:id/stats', to: 'users#stats', as: 'stats'
  get '/', to: 'application#home', as: 'home'
  get '/login', to: 'sessions#new', as: 'login_form'
  post '/login', to: 'sessions#create', as: 'login'
  post '/logout', to: 'sessions#destroy', as: 'logout'


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
