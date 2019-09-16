Rails.application.routes.draw do

  resources :tambos

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users

  root to: "home#index"
end
