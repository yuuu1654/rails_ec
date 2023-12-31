# frozen_string_literal: true

Rails.application.routes.draw do
  # dev環境でメール送信を確認
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
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
  # チェックアウト機能
  post '/checkout', to: 'checkouts#create'
  # 購入明細一覧・詳細ページ
  get '/order_details/index', to: 'checkouts#index', as: 'order_details_index'
  get '/order_details/:order_id/show', to: 'checkouts#show', as: 'order_detail_show'
  # resources :order_details, only: [:index, :show]

  # プロモーションコード適用
  post '/cart_products/update', to: 'cart_products#update'
end
