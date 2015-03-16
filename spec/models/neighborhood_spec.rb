require 'rails_helper'

RSpec.describe Neighborhood, :type => :model do
  coordinates = [[[[12.12, 12.12]], [[13.13, 13.13]], [[14.14, 14.14]]]]

  let!(:neighborhood) do
    Neighborhood.create(name: "Highland",
                        coordinates: coordinates,
                        city_id: 1,
                        center_point: coordinates[0][0][0])
  end

  it "#name" do
    expect(neighborhood.name).to eq("Highland")
  end

  it "#coordinates" do
    expect(neighborhood.coordinates).to eq(coordinates)
  end

  it "#center_point" do
    expect(neighborhood.center_point).to eq(coordinates[0][0][0])
  end

  it "#city" do
    City.create(name: "Denver")
    expect(neighborhood.city.name).to eq("Denver")
  end

  context "#time_estimates" do
    it "exist" do
      expect(neighborhood.time_estimates).to eq([])
    end

    it "stick when associated with a neighborhood" do
      neighborhood.time_estimates.create(product_type: "uberXL",
                                         time: 3000)
      neighborhood.time_estimates.create(product_type: "uberx",
                                         time: 2000)

      expect(neighborhood.time_estimates.count).to eq(2)
      expect(neighborhood.time_estimates.first.product_type).to eq("uberXL")
    end
  end

  it ".build_geojson" do

  end
end
