Rails.application.routes.draw do
  resources :reviews

  resources :order_lines do
    member do
      get 'deliver'
    end
    member do
      get 'process_line' #cannot be process due to rails bug
    end
    member do
      get 'cancel'
    end
  end
  get '/order_lines_pending' => 'order_lines#pending'

  resources :orders

  resources :products

  resources :sub_categories

  resources :categories

  resources :tables
  get 'tables-status' => 'tables#status'
  
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
