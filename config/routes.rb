# frozen_string_literal: true

Rails.application.routes.draw do
  root 'products#index'
  resources :products, only: %i[index show]

  # 商品管理機能
  namespace :admin do
    resources :products
  end

  # カート機能
  get '/cart', to: 'cart_products#show'
  # 商品一覧ページからカート追加するルート
  post 'cart_products/create', to: 'cart_products#create', as: 'add_to_cart_from_products_index'
  # 商品詳細ページからカート追加するルート
  post '/products/:id/create', to: 'cart_products#create', as: 'add_to_cart_from_products_show'
  delete 'cart_products/destroy/:product_id', to: 'cart_products#destroy', as: 'remove_from_cart'
end
