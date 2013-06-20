class FoodBusinessesController < ApplicationController
  before_filter :require_permissions, except: [:index, :show]

  def index
    @food_businesses = FoodBusiness.food_trucks
    respond_to do |format|
      format.html do
        redirect_to root_path unless current_food_business and current_food_business.is_admin
      end
      format.json
    end
  end

  def show
    @food_business = FoodBusiness.find(params[:id])
    render json: @food_business
  end

  def edit
    @business = FoodBusiness.find(params[:id])
  end

  def update
    @business = FoodBusiness.find(params[:id])
    @business.update_attributes(params[:food_business])
    if @business.save
      redirect_to edit_food_business_path(params[:id]), notice: 'Profile changes saved.'
    else
      redirect_to edit_food_business_path(params[:id]), error: 'There was an error saving the profile.'
    end
  end

  def new
    @business = FoodBusiness.new(business_type: 'stand')
  end

  def create
    @business = FoodBusiness.new
    @business.update_attributes(params[:food_business])

    if @business.save
      redirect_to edit_food_business_path(@business), notice: 'New food business added.'
    else
      redirect_to new_food_business_path(), error: 'There was an error creating the food business.'
    end
  end

  private
  def require_permissions
    redirect_to root_path unless has_permissions(params[:id])
  end

  def has_permissions(attempted_id)
    (current_food_business && (current_food_business.id == attempted_id.to_i or current_food_business.is_admin)) ? true : false
  end
end
