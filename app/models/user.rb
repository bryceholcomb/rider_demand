class User < ActiveRecord::Base
  attr_accessor :first_visit

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
    user.update_info(auth)
    user
  end

  def update_info(auth)
    first_name = auth.info.first_name
    last_name = auth.info.last_name
    email = auth.info.email
    image_url = auth.info.picture
    promo_code = auth.info.promo_code
    token = auth.credentials.token
    save
  end
end
