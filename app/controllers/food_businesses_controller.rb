class FoodBusinessesController < ApplicationController
  def index
    @food_businesses = FoodBusiness.all
  end

  def edit
    # TODO: ensure that user can edit this food business
    @business = FoodBusiness.find(params[:id])
  end

  def update
    # TODO: ensure that user can edit this food business
    @business = FoodBusiness.find(params[:id])
    @business.update_attributes(params[:food_business])
    if @business.save
      redirect_to edit_food_business_path(params[:id]), notice: 'Profile changes saved.'
    else
      redirect_to edit_food_business_path(params[:id]), error: 'There was an error saving the profile.'
    end
  end
end
