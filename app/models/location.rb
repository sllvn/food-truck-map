class Location < ActiveRecord::Base
  attr_accessible :address, :latitude, :longitude
  has_many :food_trucks, through: :schedule_entry
  has_many :schedule_entries

  def schedule_entry
    self.schedule_entries.first
  end
end
