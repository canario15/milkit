Rails.application.routes.draw do

  resources :cows, only: [:show, :update, :create, :new]
  resources :tambos

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users, :skip => [:registration]
  resources :users, only: [:show, :update, :edit]

  root to: "home#index"
end
