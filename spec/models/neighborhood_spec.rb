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

  it ".by_product_type" do
    neighborhood.time_estimates.create(product_type: "uberX")
    expect(Neighborhood.by_product_type("uberX").count).to eq(1)
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

  context '#current_time_estimate' do
    it "returns the most recent time estimate based on created_at" do
      uberx = "uberx"
      older = neighborhood.time_estimates.create(product_type: uberx,
                                         time: 3000,
                                         created_at: Date.today - 1.day)
      newer = neighborhood.time_estimates.create(product_type: uberx,
                                         time: 2000,
                                         created_at: Date.today)
      expect(neighborhood.current_time_estimate(uberx)).to eq(newer)
    end

    it 'return time estimates that match the type passed in' do
      uberXL = neighborhood.time_estimates.create(product_type: "uberXL",
                                         time: 3000)
      uberX = neighborhood.time_estimates.create(product_type: "uberX",
                                         time: 2000)
      expect(neighborhood.current_time_estimate("uberXL")).to eq(uberXL)
    end
  end
end
