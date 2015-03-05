require "rails_helper"

RSpec.describe PredictorController do
  it "redirects a guest user trying to visit the predictor path" do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(nil)

    get :index

    expect(response.status).to eq(302)
    expect(response.request.env["rack.session.options"][:path]).to eq(root_path)
    expect(flash[:alert]).to eq("Please login to view this feature")
  end
end
