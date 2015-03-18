require "rails_helper"

describe "a guest user" do
  include Capybara::DSL

  it "gets redirected when trying to visit the predictor path" do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(nil)

    visit predictor_path

    expect(current_path).to eq(root_path)
    expect(page).to have_content("Please login to view this feature")
  end

  it "can view the test drive page" do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(nil)

    visit test_drive_path

    expect(current_path).to eq(test_drive_path)
  end
end
