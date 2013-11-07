class ScheduleEntry < ActiveRecord::Base
  belongs_to :food_truck
  belongs_to :location

  attr_accessible :day, :food_truck_id, :location_id, :end_time, :start_time, :location_attributes

  accepts_nested_attributes_for :location

  def self.order_by_case
    ret = "CASE"
    %w[sunday monday tuesday wednesday thursday friday saturday].each_with_index do |day, index|
      ret << " WHEN day = '#{day}' THEN #{index}"
    end
    ret << " END"
  end

  default_scope order(self.order_by_case)
end

