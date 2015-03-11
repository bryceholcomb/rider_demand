require 'rails_helper'

RSpec.describe UberService, type: :model do
  describe "ETA endpoint" do
    context "called with a start longitude and latitude and authorization" do
      VCR.use_cassette("eta") do
        options = {start_latitude: 39.7392,
                   start_longitude: -104.9903}
        response = UberService.new("TApTByyy0vSDCbiRSeloT4AAvt7tdw").eta_times(options)

        it "returns the localized display name" do
          expect(response.first["localized_display_name"]).to eq("uberXL")
        end

        it "returns the estimate" do
          expect(response.first["estimate"]).to eq(202)
        end

        it "returns the display name" do
          expect(response.first["display_name"]).to eq("uberXL")
        end

        it "returns the product id" do
          expect(response.first["product_id"]).to eq("1c2d6363-0b64-45ad-b749-a539b186f376")
        end
      end
    end
  end
end
