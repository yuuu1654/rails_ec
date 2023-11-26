# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'products#index'
  get 'products/:id', to: 'products#show', as: 'product'

  namespace :admin do
    resources :products
  end
end
