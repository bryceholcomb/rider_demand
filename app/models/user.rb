class User < ActiveRecord::Base
  attr_accessor :first_visit

  has_many :user_cities
  has_many :cities, through: :user_cities

  after_create do |user|
    user.first_visit = true
  end

  after_find do |user|
    user.first_visit = false
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def formatted_created_at
    created_at.strftime "%m/%d/%Y"
  end

  def self.find_or_create_from_auth(auth)
    user = User.find_or_create_by(provider: auth.provider, uid: auth.uid)
    user.update_info(user, auth)
    user.save
    user
  end

  def update_info(user, auth)
    user.first_name = auth.info.first_name
    user.last_name = auth.info.last_name
    user.email = auth.info.email
    user.image_url = auth.info.picture
    user.promo_code = auth.info.promo_code
    user.token = auth.credentials.token
  end
end
