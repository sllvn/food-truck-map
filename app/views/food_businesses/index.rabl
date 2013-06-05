collection @food_businesses
attributes :name, :description, :twitter_username, :facebook_username, :website_url
child(:location) { attributes :address, :latitude, :longitude }
