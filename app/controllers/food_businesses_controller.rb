class FoodBusinessesController < ApplicationController
  def index
    @food_businesses = FoodBusiness.all
  end
end
