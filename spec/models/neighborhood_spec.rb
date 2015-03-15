require 'rails_helper'

RSpec.describe Neighborhood, type: :model do
  it ".data returns an array of features" do
    expect(Neighborhood.data("Denver").class).to eq(Array)
  end

  it "#where returns all neighborhoods" do
    expect(Neighborhood.where(city: "Denver").count).to eq(78)
    expect(Neighborhood.where(city: "San Francisco").count).to eq(37)
  end

  it "#where returns a neighborhood with attributes" do
    neighborhood = Neighborhood.where(city: "Denver").first

    expect(neighborhood.properties["name"]).to eq("Chaffee Park")
  end
end
