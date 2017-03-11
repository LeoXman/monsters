Rails.application.routes.draw do

  root 'monsters#home'

  resources :users do
    resources :messages
    resources :favorites
  end
  get '/user-monsters', to: 'users#list_monsters'

  resources :monsters do
    resources :comments
    get :like, on: :member
    get :dislike, on: :member
    get :add_favorite, on: :member
  end

  # administrator
  get '/administrator', to: 'administrator#index'

  # auth
  get '/auth', to: 'users#auth'

  # search result page
  post '/search', to: 'monsters#search'

  # resources :sessions
  post '/sessions/create', to: 'sessions#create'
  get '/sessions/delete', to: 'sessions#destroy'

end
