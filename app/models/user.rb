class User < ActiveRecord::Base
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
