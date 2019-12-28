# frozen_string_literal: true

Rails.application.routes.draw do
  resources :tambos do
    resources :cows, except: %i[index delete] do
      resources :events, except: %i[index]
    end
    get 'search_cow', to: 'cows#search_cow'
    get 'cows_to_excel', to: 'cows#cows_to_excel'
  end

  resources :notifications
  post 'notifications/:id/mark_unread', to: 'notifications#mark_unread',
                                        as: :mark_unread
  post 'notifications/:id/mark_read', to: 'notifications#mark_read',
                                      as: :mark_read
  get 'notifications_read', to: 'notifications#notifications_read',
                            as: :notifications_read

  devise_for :users, skip: %i[registration]
  resources :users, only: %i[show update edit]
  get '/user/calendar', to: 'users#calendar'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root to: 'home#index'
end
