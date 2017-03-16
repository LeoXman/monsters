Rails.application.routes.draw do

  root 'monsters#home'

  resources :users do
    resources :messages
    resources :favorites
  end
  get '/user-monsters', to: 'users#list_monsters'

  resources :monsters do
    resources :comments
    resources :vote
    get :add_favorite, on: :member
  end

  # administrator
  get '/administrator', to: 'administrator#index'

  # auth
  get '/authsite', to: 'users#auth' # Локальная форма авторизации
  post '/authlocal', to: 'sessions#createlocal' # Создание локальной сессии
  post '/oauth/request_token' => 'sessions#new'
  match '/auth/:provider/callback' => 'sessions#create', via: [:get, :post]
  match '/auth/failure' => 'sessions#failure', via: [:get, :post]
  match '/login' => 'sessions#new', :as => :login, via: [:get, :post] # Ссылки на авторизации через соц сети
  match '/logout' => 'sessions#destroy', :as => :logout, via: [:get, :post]

  # search result page
  post '/search', to: 'monsters#search'

  # resources :sessions
  post '/sessions/create', to: 'sessions#create'
  get '/sessions/delete', to: 'sessions#destroy'

end
