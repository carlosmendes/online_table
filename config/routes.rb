Rails.application.routes.draw do
  resources :reviews

  resources :order_lines

  resources :orders

  resources :products

  resources :sub_categories

  resources :categories

  resources :tables
  
  resources :users
  
  #users login
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  get '/auth/:provider/callback' => 'sessions#create_from_social'
  get '/signin' => 'sessions#new', :as => :signin
  get '/signout' => 'sessions#destroy', :as => :signout
  get '/auth/failure' => 'sessions#failure'
    
  get    'menu'    => 'products#menu' 

  root to: 'pages#home'
end
