Rails.application.routes.draw do
  resources :users, only: [:show, :new, :create, :edit, :update, :destroy]
  resources :items
  resources :bids, only: [:index, :show, :new, :create, :destroy]

  get '/', to: 'application#home', as: 'home'
  get '/login', to: 'login#login_form', as: 'login_form'
  post '/login', to: 'login#login', as: 'login'
  get '/logout', to: 'login#destroy', as: 'logout'


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
