class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :address
      t.float :latitude
      t.float :longitude
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end
  end
end
