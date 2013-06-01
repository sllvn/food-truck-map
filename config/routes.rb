Foodtruckmap::Application.routes.draw do
  devise_for :food_businesses

  root :to => 'map#index'
end
