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

  it "has a formatted created at" do
    expect(valid_user.formatted_created_at).to eq "02/01/2015"
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
end
