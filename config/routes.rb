Rails.application.routes.draw do
  devise_for :users
  root to: 'messages#index'

  resources :messages
  resources :users do
    member do
      post :downgrade_role
      post :upgrade_role
    end
  end
end
