class FoodBusiness < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :twitter_username, :facebook_username, :website_url, :location
  has_one :location

  def display_name
    self.name.blank? ? self.email : self.name
  end
end
