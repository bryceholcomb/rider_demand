require 'rails_helper'

RSpec.describe GeojsonParser, :type => :model do
  it "returns an array of features" do
    expect(GeojsonParser.new("Denver").perform.class).to eq(Array)
    expect(GeojsonParser.new("San Francisco").perform.class).to eq(Array)
  end
end
