class AddTypeToFoodTrucks < ActiveRecord::Migration
  def change
    add_column 'food_trucks', :business_type, :string
  end
end
