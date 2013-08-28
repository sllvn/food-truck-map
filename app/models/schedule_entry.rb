class ScheduleEntry < ActiveRecord::Base
  belongs_to :food_business
  belongs_to :location
  attr_accessible :day, :endtime, :starttime
end
