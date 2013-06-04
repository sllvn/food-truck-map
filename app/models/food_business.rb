class FoodBusiness < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :twitter_username, :facebook_username, :website_url
  has_one :location, primary_key: 'location_id', foreign_key: 'id'
  # attr_accessible :title, :body

  def display_name
    self.name.empty? ? self.email : self.name
  end
end
