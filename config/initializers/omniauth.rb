Rails.application.config.middleware.use OmniAuth::Builder do
  provider :uber, ENV['UBER_CLIENT_ID'], ENV['UBER_SECRET']
end

if Rails.env.production?
  OmniAuth.config.full_host = "https://rider-demand.herokuapp.com"
end
