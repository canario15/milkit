Rails.application.routes.draw do

  resources :cows
  resources :tambos

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users

  root to: "home#index"
end
