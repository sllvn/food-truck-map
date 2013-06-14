class FoodBusiness < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :twitter_username, :facebook_username, :website_url, :location, :is_admin, :business_type
  has_one :location

  scope :food_trucks, where('is_admin is null or is_admin = ?', false)
  scope :administrators, where('is_admin = ?', true)

  def display_name
    self.name.blank? ? self.email : self.name
  end

  def type
    self.business_type.blank? ? 'stand' : self.business_type
  end

  def status
    if (self.location.start_time.nil? or self.location.start_time <= Time.now) and (self.location.end_time.nil? or self.location.end_time >= Time.now)
      'open'
    else
      'closed'
    end
  end
end
