require 'rails_helper'

RSpec.describe City, :type => :model do
  let!(:city) do
    City.new(name: "Denver",
             latitude: 39.01,
             longitude: -104.01)
  end

  it "#name" do
    expect(city.name).to eq("Denver")
  end

  it "#latitude" do
    expect(city.latitude).to eq(39.01)
  end

  it "#longitude" do
    expect(city.longitude).to eq(-104.01)
  end

  it "#lat_long" do
    expect(city.lat_long).to eq("39.01, -104.01")
  end

  context "#neighborhoods" do
    it "exits" do
      expect(city.neighborhoods).to eq([])
    end

    it "stick when added to a city" do
      city.save
      city.neighborhoods.create(name: "Highland")

      expect(city.neighborhoods.first.name).to eq("Highland")
    end
  end
end
