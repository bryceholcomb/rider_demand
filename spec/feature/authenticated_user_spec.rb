require "rails_helper"

describe "an authenticated user" do
  include Capybara::DSL

  xit "can add more info after authentication" do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit root_path
    click_link_or_button "Login with Uber"
    fill_in "email", with: "brycecholcomb@gmail.com"
    fill_in "password", with: "password"
    expect(current_path).to eq edit_user_path
    click_link_or_button "Submit"
    expect(current_path).to eq predictor_path
  end

  it "can edit their information" do
    user = create(:user, created_at: Date.new(2015, 3, 1))
    create(:city, name: "San Francisco")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit root_path
    click_link_or_button "Edit Profile"
    fill_in "user_phone_number", with: "3364290800"
    select "San Francisco", from: "user_cities"
    fill_in "user_avg_weekly_rides", with: 100
    click_link_or_button "Submit"
    expect(page).to have_content("You have successfully updated your information")
    expect(current_path).to eq user_path(user)
    expect(page).to have_content "Bryce Holcomb"
    expect(page).to have_content "bryce@example.com"
    expect(page).to have_content "ABCD"
    expect(page).to have_content "03/01/2015"
    expect(page).to have_content "100"
    expect(page).to have_content "San Francisco"
  end

  it "can view their profile" do
    user = create(:user, created_at: Date.new(2015, 3, 1))
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit root_path
    click_link_or_button "View Profile"
    expect(page).to have_content "Bryce Holcomb"
    expect(page).to have_content "bryce@example.com"
    expect(page).to have_content "ABCD"
    expect(page).to have_content "03/01/2015"
  end

  xit "can log out" do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit root_path
    click_link_or_button "Logout"
    expect(page).to have_content "You have successfully logged out"
    expect(page).to have_content "Login with Uber"
  end

  xit "is redirected to add more info if this is first signup" do
    user = create(:user, provider: "uber")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  end

  xit "can see the predictor map page if they are a returning user" do
    create(:user, provider: "uber")
    user = User.find_by(provider: "uber")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  end
end
