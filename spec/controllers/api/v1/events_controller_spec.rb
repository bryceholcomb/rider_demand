require 'rails_helper'

RSpec.describe Api::V1::EventsController, type: :controller do
  let!(:city) do
    City.create(name: "Denver",
                latitude: 39.739,
                longitude: -104.99)
  end

  context "#index" do
    context "with just city parameter" do
      it "responds with serialized json events" do
        VCR.use_cassette("controllers/api/v1/events#index?city") do
          get :index, city: "Denver"
        end

        events = JSON.parse(response.body)["events"]

        expect(events.first["properties"]["title"]).to eq("Alkaline Trio")
      end
    end

    context "with city and category parameters" do
      it "responds with serialized json events" do
        VCR.use_cassette("controllers/api/v1/events#index?city&category") do
          get :index, city: "Denver", category_id: 1
        end

        events = JSON.parse(response.body)["events"]

        expect(events.first["properties"]["title"]).to eq("Alkaline Trio")
      end
    end

    context "with no parameters" do
      it "responds with serialized json events" do
        VCR.use_cassette("controllers/api/v1/events#index") do
          get :index
        end

        events = JSON.parse(response.body)["events"]

        expect(events.first["properties"]["title"]).to eq("Alkaline Trio")
      end
    end
  end
end
