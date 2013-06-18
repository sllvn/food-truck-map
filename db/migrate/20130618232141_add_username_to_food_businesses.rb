class AddUsernameToFoodBusinesses < ActiveRecord::Migration
  def change
    add_column :food_businesses, :username, :string
  end
end
