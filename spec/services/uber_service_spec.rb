require 'rails_helper'

RSpec.describe UberService, type: :model do
  describe "ETA endpoint" do
    context "called with a start longitude and latitude and authorization" do
      VCR.use_cassette("eta") do
        options = {
          start_latitude: 39.7392,
          start_longitude: -104.9903
        }
        response = UberService.new(ENV["UBER_DEFAULT_BEARER_TOKEN"]).eta_times(options)

        it "returns the localized display name" do
          expect(response.first["localized_display_name"]).to eq("uberX")
        end

        it "returns the estimate" do
          expect(response.first["estimate"]).to eq(88)
        end

        it "returns the display name" do
          expect(response.first["display_name"]).to eq("uberX")
        end

        it "returns the product id" do
          expect(response.first["product_id"]).to eq("b746437e-eab6-44ca-8079-25dfd6f861ab")
        end
      end
    end
  end
end
