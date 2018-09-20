Rails.application.routes.draw do
  resources :orders

  get 'store/index'

  get 'store/items'

  get 'store/item'

  get 'sessions/new'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root 'pages#home'
  get 'pages/home'
  get 'pages/about'
  get '/login', to:'sessions#new'
  post '/login', to:'sessions#create'
  delete '/logout', to:'sessions#destroy'
  get '/signup', to:'users#new'
  post '/signup', to:'users#create'
  get '/home', to:'store#index'
  get '/store', to:'store#index'
  get '/category', to:'store#items'
  get 'store/cart', to:'store#cart'
  delete 'store/cart', to:'store#empty_cart', as: :empty_cart

  resources :users
  resources :items
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

#
#  map.with_options(:controller => 'store', :path_prefix => 'store') do |store|
#    store.store_cart_item 'cart/items/:id', :action => 'add_to_cart', :method => :post
#    store.store_items ':category_id/items', :action => 'items'
#  end

  post 'cart/items/:id', to: 'store#add_to_cart', as: :store_cart_item
  get ':category_id/items', to: 'store#items', as: :items_per_cat
  get 'order/:id/handle', to: 'orders#handle', as: :order_handle
  post 'order/:id/handled', to: 'orders#handled', as: :order_handled
  post 'store/order', to: 'store#order', as: :store_order
  get 'store/checkout', to: 'store#checkout', as: :store_checkout
  post 'store/payment', to: 'store#paypal', as: :store_paypal
  post 'store/express_checkout', to: 'store#express_checkout', as: :store_express_checkout

  get 'store/purchase', to: 'store#purchase', as: :paypal_purchase
  get 'store/cancel', to: 'store#cancel', as: :paypal_cancel
  get 'store/complete', to: 'store#complete', as: :paypal_complete
  get 'store/notify', to: 'store#ipn', as: :paypal_ipn

end
