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
  post 'order_lines/create'
  get '/order_lines_pending' => 'order_lines#pending'

  resources :orders do
    member do
      get 'request_waiter'
    end
    member do
      get 'processing'
    end
    member do
      get 'request_payment'
    end
    member do
      get 'pay'
    end
    member do
      get 'cancel'
    end
  end
  get '/current_order' => 'orders#current'
  get '/orders_waiting_waiter' => 'orders#waiting_waiter'
  get '/orders_waiting_payment' => 'orders#waiting_payment'
  
  resources :products
  get 'menu' => 'products#menu' 

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
    

  root to: 'pages#home'
end
