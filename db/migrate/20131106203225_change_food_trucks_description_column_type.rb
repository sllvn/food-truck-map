class ChangeFoodTrucksDescriptionColumnType < ActiveRecord::Migration
  def change
    change_column :food_trucks, :description, :text
  end
end
