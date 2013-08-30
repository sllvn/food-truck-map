Foodtruckmap::Application.routes.draw do
  resources :food_trucks

  root :to => 'map#index'
end
