Rails.application.config.middleware.use OmniAuth::Builder do
  provider :uber, ENV['UBER_CLIENT_ID'], ENV['UBER_SECRET']
end
