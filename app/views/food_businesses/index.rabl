collection @food_businesses
attributes :id, :name, :description, :twitter_username, :facebook_username, :website_url, :type
child(:location) { attributes :address, :latitude, :longitude }
