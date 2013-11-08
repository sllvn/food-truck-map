class FoodTruck < ActiveRecord::Base
  has_many :schedule_entries
  has_many :locations, through: :schedule_entries

  attr_accessible :name, :description, :twitter_username, :facebook_username, :website_url, :schedule_entries_attributes

  accepts_nested_attributes_for :schedule_entries

  default_scope order(:name)

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

  def current_location
    today = schedule[Time.now.strftime("%A").downcase]
    if today and today.start_time and today.end_time
      # TODO: write tests for this, this is very fragile
      # hack around rails time zone weirdness for standard vs daylight time
      start_time = today.start_time.localtime
      end_time = today.end_time.localtime
      offset = Time.now.formatted_offset.to_i - today.start_time.formatted_offset.to_i 
      start_time += offset.hours
      end_time += offset.hours

      today
    else
      nil
    end
  end

  def self.active_trucks
    ScheduleEntry.where(day: Time.now.strftime("%A").downcase).where('start_time <= ? and end_time >= ?', Time.now, Time.now).map { |s| s.food_truck }
  end
end

