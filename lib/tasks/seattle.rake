namespace :seattle do
  desc "Import food truck data from JSON file"
  task :import => :environment do
    trucks = JSON.parse(File.read('./lib/tasks/data/geocoded_trucks.json'))
    trucks.each do |truck|
      food_truck = FoodTruck.find_or_create_by_name truck['name']
      if truck['links']
        food_truck.twitter_username = truck['links']['twitter']
        food_truck.facebook_username = truck['links']['facebook']
        food_truck.website_url = truck['links']['website']
      end
      food_truck.description = truck['description']
      # TODO: truck payment info
      food_truck.save

      if truck['schedule']
        truck['schedule'].each do |day, location|
          truck_location = Location.find_or_create_by_address location['formatted_address']
          truck_location.latitude = location['lat']
          truck_location.longitude = location['lng']
          truck_location.save

          schedule_entry = ScheduleEntry.where(food_truck_id: food_truck.id, day: day).first ||
                           ScheduleEntry.create(food_truck_id: food_truck.id, day: day)
          schedule_entry.start_time, schedule_entry.end_time = TimeRangeParser.parse(location['time']) if location['time']
          schedule_entry.location = truck_location
          schedule_entry.save
        end
      end

      puts "imported truck #{food_truck.name}"
    end
    puts 'done with import'
  end
end

class TimeRangeParser
  def self.parse(text)
    begin
      text.split(/-/).map { |time| Time.parse(time) }
    rescue ArgumentError
      puts "Error parsing time: #{text}"
      [nil, nil]
    end
  end
end
