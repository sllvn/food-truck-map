class RemoveUniqueEmailConstraintFromFoodBusinesses < ActiveRecord::Migration
  def change
    remove_index :food_businesses, :email
  end
end
