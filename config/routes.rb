Foodtruckmap::Application.routes.draw do
  devise_for :food_businesses

  resources :food_businesses

  match "/checkin" => "map#checkin"

  root :to => 'map#index'
end
