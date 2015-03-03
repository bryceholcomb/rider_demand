require 'rails_helper'

RSpec.describe Uber, :type => :model do
  describe "ETA endpoint" do
    it "returns a hash" do
      token = "1234"
      VCR.use_cassette("eta") do
        expect(Uber.new(token).eta).to be_a(Hash)
      end
    end
  end
end
