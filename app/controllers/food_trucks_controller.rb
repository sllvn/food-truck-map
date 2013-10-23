class FoodTrucksController < ApplicationController
  def index
    @food_trucks = FoodTruck.active_trucks
    render json: @food_trucks, each_serializer: FoodTruckSerializer, root: false
  end

  def show
    @food_truck = FoodTruck.find(params[:id])
    render json: @food_truck
  end
end
