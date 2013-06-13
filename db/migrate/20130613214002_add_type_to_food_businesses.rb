class AddTypeToFoodBusinesses < ActiveRecord::Migration
  def change
    add_column 'food_businesses', :business_type, :string
  end
end
