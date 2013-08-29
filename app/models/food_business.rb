class FoodBusiness < ActiveRecord::Base
  has_many :schedule_entries

  def type
    self.business_type.blank? ? 'stand' : self.business_type
  end

  def status
    nil
  end


  def schedule
    # TODO: allow for more than one schedule item per day
    days = {}
    %w[sunday monday tuesday wednesday thursday friday saturday].each do |day|
      # TODO: convert to find_by with rails4
      days[day] = self.schedule_entries.where('day = ?', day).first
    end
    days
  end

  def current_location; end # TODO

  def all_locations; end # TODO

  def next_location; end # TODO: useful if they're currently inactive

  def self.active_trucks
    # TODO: find schedules where day = today and current time is between starttime and endtime
  end
end

