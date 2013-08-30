class CreateScheduleEntries < ActiveRecord::Migration
  def change
    create_table :schedule_entries do |t|
      t.references :food_truck
      t.references :location
      t.string :day
      t.time :start_time
      t.time :end_time

      t.timestamps
    end
    add_index :schedule_entries, :food_truck_id
    add_index :schedule_entries, :location_id
  end
end
