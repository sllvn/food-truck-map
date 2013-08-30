class ScheduleEntry < ActiveRecord::Base
  belongs_to :food_truck
  belongs_to :location
  attr_accessible :day, :food_truck_id, :location_id, :end_time, :start_time
end
