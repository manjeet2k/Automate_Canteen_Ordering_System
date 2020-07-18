Rails.application.routes.draw do

  root 'pages#home'

  resources :employee_profiles do
    collection do
      get :dashboard
    end
  end

  resources :chef_profiles do
    collection do
      get :dashboard
      get :orders
    end
    
    member do
      get :order_update
      patch :order_update
    end
  end
  resources :user_profiles do
    collection do
      get :dashboard
    end
  end

  resources :companies
  resources :users, except: [:new]
  resources :food_stores
  resources :food_items
  resources :food_categories


  get    'signup', to: 'users#new'
  get    'login' , to: 'sessions#new'
  post   'login' , to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get   'dashboard',    to: 'admins#dashboard'
  get   "admin/orders", to: "admins#order"
  get   "admin/order/:id/approve", to: "admins#approve_order", as: "approve_order"
  get   'chef/:id/approve',     to: 'admins#approve_chef', as: 'approve_chef'
  get   'employee/:id/approve', to: 'admins#approve_employee', as: 'approve_employee'

  get 'menu', to: "pages#menu"
  get 'error',to: "pages#show"
   
  post   'carts/add'
  get    'cart',   to: 'carts#show'
  get    'orders', to: 'carts#order_show', as: 'order_show'
  patch  'cart_item/:id/update', to: 'cart_items#update', as: 'item_update'
  patch  'order/:id',     to: 'carts#order',       as: 'cart_order'
  delete 'cart_item/:id', to: 'cart_items#delete', as: 'item_delete'  
end
