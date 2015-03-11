require 'rails_helper'

RSpec.describe Eventful, :type => :model do
  describe "search endpoint" do
    context "with a key, location, and date params" do
      VCR.use_cassette("events") do
        options = {app_key: ENV["EVENTFUL_KEY"],
                   location: "Denver",
                   date: "Today"}
        response = Eventful.new.events(options)

        it "returns events" do
          expect(response["events"]["event"].count).to eq(10)
        end

        it "returns an event with a title" do
          expect(response["events"]["event"].first["title"]).to eq("Passionate Lover Program - Tuesday Boulder Group w Joanna - Winter 2015")
        end

        it "returns an event with an image" do
          expect(response["events"]["event"].first["image"]["medium"]["url"]).to eq("http://s1.evcdn.com/images/medium/I0-001/017/485/552-2.jpeg_/passionate-lover-program-tuesday-boulder-group-w-52.jpeg")
        end
      end
    end
  end
end
