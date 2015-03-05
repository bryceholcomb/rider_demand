require 'rails_helper'

RSpec.describe User, :type => :model do
  let!(:valid_user) do
    User.new(first_name: "Bryce",
             last_name: "Holcomb",
             email: "bryce@example.com",
             provider: "uber",
             token: "1234",
             uid: "123",
             created_at: Date.new(2015, 2, 1),
             image_url: "photo.jpg",
             promo_code: "B234C")
  end

  it "is valid" do
    expect(valid_user).to be_valid
  end

  it "has a full name" do
    expect(valid_user.full_name).to eq "Bryce Holcomb"
  end

  it "has a formatted date" do
    expect(valid_user.formatted_date(valid_user.created_at)).to eq "02/01/2015"
  end

  it "can have many cities" do
    expect(valid_user.cities).to eq([])
  end

  it "has many cities" do
    valid_user.save
    valid_user.cities.create(name: "Denver")
    valid_user.cities.create(name: "San Francisco")
    valid_user.cities.create(name: "Portland")

    expect(valid_user.cities.count).to eq(3)
    expect(valid_user.cities.first.name).to eq("Denver")
  end

  it "is their first visit upon creation" do
    user = create(:user)

    expect(user.first_visit).to eq(true)
  end

  it "is not their first visit upon finding" do
    create(:user, provider: "uber")

    user = User.find_by(provider: "uber")

    expect(user.first_visit).to eq(false)
  end

  it "is created if not found when logging in" do
    auth = create_omni_auth_hash
    expect(User.count).to eq(0)

    User.find_or_create_from_auth(auth)

    user = User.first
    expect(user.first_name).to eq("Bryce")
    expect(user.last_name).to eq("Holcomb")
    expect(user.email).to eq("bryce@example.com")
    expect(user.image_url).to eq("headshot.jpg")
    expect(user.promo_code).to eq("ABCD")
    expect(user.token).to eq("1234")
  end

  it "is found if the record already exists" do
    auth = create_omni_auth_hash
    create(:user, provider: "uber", uid: "1234")
    expect(User.count).to eq(1)

    user = User.find_or_create_from_auth(auth)

    expect(User.count).to eq(1)
    expect(user.first_name).to eq("Bryce")
    expect(user.last_name).to eq("Holcomb")
    expect(user.email).to eq("bryce@example.com")
    expect(user.image_url).to eq("headshot.jpg")
    expect(user.promo_code).to eq("ABCD")
    expect(user.token).to eq("1234")
  end

  it "'s information is updated when different from the existing record" do
    auth = create_omni_auth_hash
    create(:user,
           first_name: "John",
           last_name: "Doe",
           email: "john@example.com",
           provider: "uber",
           uid: "1234")
    expect(User.count).to eq(1)

    user = User.find_or_create_from_auth(auth)

    expect(User.count).to eq(1)
    expect(user.first_name).to_not eq("John")
    expect(user.first_name).to eq("Bryce")
    expect(user.last_name).to_not eq("Doe")
    expect(user.last_name).to eq("Holcomb")
    expect(user.email).to_not eq("john@example.com")
    expect(user.email).to eq("bryce@example.com")
  end

  def create_omni_auth_hash
    auth = OmniAuth::AuthHash.new
    auth[:info] = {first_name: "Bryce",
                   last_name: "Holcomb",
                   email: "bryce@example.com",
                   picture: "headshot.jpg",
                   promo_code: "ABCD"}
    auth[:credentials] = {token: "1234"}
    auth[:provider] = "uber"
    auth[:uid] = "1234"
    auth
  end
end
