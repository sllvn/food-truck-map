class FoodTruckSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :status, :twitter_username, :facebook_username, :website_url, :type
  has_one :current_location, serializer: LocationSerializer
end
