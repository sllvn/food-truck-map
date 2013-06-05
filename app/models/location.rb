class Location < ActiveRecord::Base
  attr_accessible :address, :latitude, :longitude
  belongs_to :food_business
end
