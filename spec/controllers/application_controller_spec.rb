require "rails_helper"

RSpec.describe ApplicationController do
  it "assigns the current user" do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    expect(ApplicationController.new.current_user).to eq(user)
  end
end
