class AddFieldsToFoodBusinesses < ActiveRecord::Migration
  def change
    change_table :food_businesses do |t|
      t.string :name
      t.string :description
      t.references :location
      t.string :twitter_username
      t.string :facebook_username
      t.string :website_url
    end
  end
end
