# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'products#index'
  get 'products/:id', to: 'products#show', as: 'product'

  namespace :admin do
    resources :products
  end
  # カート機能
  resources :products, only: %i[index show] do
    # post '/products/add_to_cart' to: 'product#show'
    # post '/products/:id/add_to_cart' to: 'product#show'
    member do
      post :add_to_cart # 商品詳細ページからのアクション / URL: /products/:id/add_to_cart
    end
  end
  get '/cart', to: 'products#show_cart'
  post '/add_to_cart', to: 'products#add_to_cart' # 商品一覧ページからのアクション
  delete '/remove_from_cart/:product_id', to: 'products#remove_from_cart', as: 'remove_from_cart'
end
