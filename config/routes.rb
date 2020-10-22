Rails.application.routes.draw do
  root to: 'items#index'
  devise_for :users
  resources :items, only: [:index, :new, :create, :show, :edit, :update, :destroy]
  resources :orders, only: [:index, :new, :create]
end