# frozen_string_literal: true

Rails.application.routes.draw do
  resources :cows, except: %i[index delete]
  # post '/cows/:id/event', to: 'cows#save_event'

  resources :tambos

  resources :events, except: %i[index]

  resources :users, only: %i[show update edit]
  devise_for :users, skip:  %i[registration]
  get '/user/calendar', to: 'users#calendar'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root to: 'home#index'
end
