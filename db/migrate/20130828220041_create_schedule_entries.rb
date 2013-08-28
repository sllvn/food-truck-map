class CreateScheduleEntries < ActiveRecord::Migration
  def change
    create_table :schedule_entries do |t|
      t.references :food_business
      t.references :location
      t.string :day
      t.time :starttime
      t.time :endtime

      t.timestamps
    end
    add_index :schedule_entries, :food_business_id
    add_index :schedule_entries, :location_id
  end
end
