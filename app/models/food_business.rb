class FoodBusiness < ActiveRecord::Base
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, authentication_keys: [:login]

  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :twitter_username, :facebook_username, :website_url, :location, :is_admin, :business_type, :username
  # Virtual attribute for authenticating by either username or email
  # This is in addition to a real persisted field like 'username'
  attr_accessor :login
  attr_accessible :login

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

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end
end

