FoodTruckMap::Application.routes.draw do
  scope 'api' do
    resources :food_trucks
  end

  root :to => 'map#index'
end
