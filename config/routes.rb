# frozen_string_literal: true

Rails.application.routes.draw do
  resources :cows, except: %i[index delete]
  get 'search_cow', to: 'cows#search_cow'
  resources :tambos

  resources :events, except: %i[index]

  devise_for :users, skip:  %i[registration]
  resources :users, only: %i[show update edit]
  get '/user/calendar', to: 'users#calendar'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root to: 'home#index'
end
