require 'rails_helper'

RSpec.describe User, :type => :model do
  let!(:valid_user) do
    User.new(first_name: "Bryce",
             last_name: "Holcomb",
             email: "bryce@example.com",
             provider: "uber",
             token: "1234",
             uid: "123",
             image_url: "photo.jpg",
             promo_code: "B234C")
  end

  it "is valid" do
    expect(valid_user).to be_valid
  end

  context "is not valid" do
  end
end
