class FoodTrucksController < ApplicationController
  def index
    @food_trucks = FoodTruck.active_trucks
  end

  def show
    @food_truck = FoodTruck.find(params[:id])
    render json: @food_truck
  end
end
