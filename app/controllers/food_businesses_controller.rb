class FoodBusinessesController < ApplicationController
  def index
    @food_businesses = FoodBusiness.active_trucks
  end

  def show
    @food_business = FoodBusiness.find(params[:id])
    render json: @food_business
  end
end
