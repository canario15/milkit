Rails.application.routes.draw do

  resources :cows, except: %i[index delete]
  resources :tambos

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users, skip:  %i[registration]
  resources :users, only: %i[show update edit]

  root to: "home#index"
end
