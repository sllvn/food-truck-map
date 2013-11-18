class FoodTruckSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :status, :twitter_username, :facebook_username, :website_url, :type, :tag_list
  has_one :current_location, serializer: ScheduleEntrySerializer

  def current_location
    object.schedule_for_day(Time.now.strftime("%A").downcase)
  end
end
