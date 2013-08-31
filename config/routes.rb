Foodtruckmap::Application.routes.draw do
  resources :food_trucks
  root :to => 'map#index'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
end

