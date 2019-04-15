require 'sidekiq/web'

Rails.application.routes.draw do

  mount Notifications::Engine => "/notifications"
  resources :orders
  resources :friendships
  resources :groups
  
  namespace :admin do
    resources :users 
      resources :announcements
    resources :services
    root to: "users#index"
  end

  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  get '/order/:id' => 'orders#finish', :as => :finish_order


  resources :announcements, only: [:index]
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  root to: 'home#index'
end
