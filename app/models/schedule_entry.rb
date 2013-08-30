class ScheduleEntry < ActiveRecord::Base
  belongs_to :food_business
  belongs_to :location
  attr_accessible :day, :food_business_id, :location_id, :end_time, :start_time
end
