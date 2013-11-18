class FoodTruck < ActiveRecord::Base
  has_many :schedule_entries
  has_many :locations, through: :schedule_entries

  attr_accessible :name, :description, :twitter_username, :facebook_username, :website_url, :schedule_entries_attributes, :tag_list

  accepts_nested_attributes_for :schedule_entries, reject_if: :all_blank, allow_destroy: true

  default_scope order(:name)

  acts_as_taggable

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

  def schedule_for_day(day)
    self.schedule_entries.where('day = ?', day).first
  end

  def self.active_trucks
    ScheduleEntry.where(day: Time.now.strftime("%A").downcase).where('start_time <= ? and end_time >= ?', Time.now, Time.now).map { |s| s.food_truck }
  end
end

