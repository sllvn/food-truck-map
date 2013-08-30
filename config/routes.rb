Foodtruckmap::Application.routes.draw do
  resources :food_businesses

  root :to => 'map#index'
end
