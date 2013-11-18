class MergeScheduleEntriesAndLocations < ActiveRecord::Migration
  def up
    add_column :schedule_entries, :address, :string
    add_column :schedule_entries, :latitude, :float
    add_column :schedule_entries, :longitude, :float

    puts 'Populating location data'
    ScheduleEntry.all.each do |schedule_entry|
      schedule_entry.address = schedule_entry.location.address
      schedule_entry.latitude = schedule_entry.location.latitude
      schedule_entry.longitude = schedule_entry.location.longitude
      schedule_entry.save
    end

    remove_column :schedule_entries, :location_id
    drop_table :locations
  end

  def down
    create_table :locations do |t|
      t.string :address
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
    add_column :schedule_entries, :location_id, :integer
    add_index :schedule_entries, :location_id

    puts 'Re-populating location table'
    ScheduleEntry.all.each do |schedule_entry|
      Location.create(
        address: schedule_entry.address ,
        latitude: schedule_entry.latitude, 
        longitude: schedule_entry.longitude
      )
      schedule_entry.location_id = Location.last.id
      schedule_entry.save
    end

    remove_column :schedule_entries, :address
    remove_column :schedule_entries, :latitude
    remove_column :schedule_entries, :longitude
  end
end
