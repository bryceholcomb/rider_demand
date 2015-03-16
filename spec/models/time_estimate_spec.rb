require 'rails_helper'

RSpec.describe TimeEstimate, :type => :model do
  let!(:neighborhood) do
    Neighborhood.create(name: "Highland",
                        coordinates: [12.12, 12,12],
                        center_point: [0, 0])
  end

  let!(:estimate) do
    TimeEstimate.new(product_type: "Uber XL",
                     time: 3000,
                     neighborhood_id: 1)
  end

  it "#product_type" do
    expect(estimate.product_type).to eq("Uber XL")
  end

  it "#time" do
    expect(estimate.time).to eq(3000)
  end

  it "#minutes" do
    expect(estimate.minutes).to eq(30)
  end

  it "#neighborhood" do
    expect(estimate.neighborhood).to eq(neighborhood)
  end
end
