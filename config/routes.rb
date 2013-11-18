FoodTruckMap::Application.routes.draw do
  devise_for :users,  controllers: { sessions: 'admin/sessions' }

  namespace :admin do
    resources :users
    resources :food_trucks

    get '/' => 'dashboard#index'
  end

  scope 'api' do
    resources :food_trucks
  end

  root :to => 'map#index'
end
