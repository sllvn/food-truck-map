class AddAdminTypeToUsers < ActiveRecord::Migration
  def change
    add_column 'food_businesses', :is_admin, :boolean
  end
end
