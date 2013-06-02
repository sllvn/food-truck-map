collection @food_businesses
attributes :name, :description, :location_id, :twitter_username, :facebook_username, :website_url
child(:location) { attributes :address, :latitude, :longitude }
