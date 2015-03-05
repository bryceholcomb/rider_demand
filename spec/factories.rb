FactoryGirl.define do
  factory :user do
    first_name "Bryce"
    last_name "Holcomb"
    email "bryce@example.com"
    provider "uber"
    token "12345"
    uid "123"
    image_url "photo.jpg"
    promo_code "ABCD"
    uber_start_date Date.new
    avg_weekly_rides 10
  end

  factory :city do
    name "Denver"
  end
end
