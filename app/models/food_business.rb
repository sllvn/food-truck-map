class FoodBusiness < ActiveRecord::Base
  has_many :schedule_entries

  def type
    # TODO: update this for seattle
    self.business_type.blank? ? 'stand' : self.business_type
  end

  def status
    # TODO: fix this
    'open'
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

  def location
    today = schedule[Time.now.strftime("%A").downcase]
    if today
      # TODO: write tests for this, this is very fragile
      # hack around rails time zone weirdness for standard vs daylight time
      start_time = today.starttime.localtime
      end_time = today.endtime.localtime
      offset = Time.now.formatted_offset.to_i - today.starttime.formatted_offset.to_i 
      start_time += offset.hours
      end_time += offset.hours

      location = today.location
      {
        address: location.address,
        latitude: location.latitude,
        longitude: location.longitude,
        hours: "#{start_time.strftime('%I:%M %P')} - #{end_time.strftime('%I:%M %P')}"
      }
    else
      nil
    end
  end

  def self.active_trucks
    ScheduleEntry.where(day: Time.now.strftime("%A").downcase).where('starttime <= ? and endtime >= ?', Time.now, Time.now).map { |s| s.food_business }
  end
end

