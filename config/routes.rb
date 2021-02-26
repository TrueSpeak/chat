# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root to: 'messages#index'

  resources :messages
  resources :users do
    member do
      patch :downgrade_role
      patch :upgrade_role
    end
  end

  mount ActionCable.server => '/cable'
end
