require 'sidekiq/web'

Rails.application.routes.draw do

  namespace :admin do
    resources :users 
    resources :announcements
    resources :services
    root to: "users#index"
  end

  mount Notifications::Engine => "/notifications"
  
  resources :orders do
    resources :order_users do
      resources :order_details
    end
  end

  resources :friendships

  resources :groups do 
    resources :group_members
  end
  
  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end
  
  get '/order/:id' => 'orders#finish', :as => :finish_order
  get '/order/:user/:id' => 'order_users#join', :as => :join_order
  get '/orders/:order_id/order_users/add/:group_id' => 'order_users#addGroup', :as => :add_group

  resources :announcements, only: [:index]
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  root to: 'home#index'
end
