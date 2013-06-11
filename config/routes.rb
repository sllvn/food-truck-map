Foodtruckmap::Application.routes.draw do
  devise_for :food_businesses, :path_prefix => 'my'
  resources :food_businesses

  match '/checkin' => 'map#checkin'

  root :to => 'map#index'
end
