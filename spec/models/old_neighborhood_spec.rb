require 'rails_helper'

RSpec.describe OldNeighborhood, type: :model do
  it ".data returns an array of features" do
    expect(OldNeighborhood.data("Denver").class).to eq(Array)
  end

  it "#where returns all neighborhoods" do
    expect(OldNeighborhood.where(city: "Denver").count).to eq(78)
    expect(OldNeighborhood.where(city: "San Francisco").count).to eq(37)
  end

  it "#where returns a neighborhood with attributes" do
    neighborhood = OldNeighborhood.where(city: "Denver").first

    expect(neighborhood.properties["name"]).to eq("Chaffee Park")
  end
end
