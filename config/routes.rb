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

  # search result page
  post '/search', to: 'monsters#search'

  # Сессии
  post '/auth_social', to: 'sessions#create' # Создание сессии с помощью соц.сетей
  post '/auth_local', to: 'sessions#create_via_password' # Создание сессии с помощью пароля
  get '/sessions/signout' => 'sessions#sign_out'
  match '/auth/:provider/callback' => 'sessions#create', via: [:get, :post]
  match '/auth/failure' => 'sessions#failure', via: [:get, :post]

end
