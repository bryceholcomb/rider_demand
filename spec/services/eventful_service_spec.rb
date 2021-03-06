require 'rails_helper'

RSpec.describe EventfulService, :type => :model do
  describe "search endpoint" do
    context "with overidden" do
      context "date option" do
        VCR.use_cassette("eventful_spec/events_with_date_override") do
          options = { date: "2015031000-2015031000" }

          events = EventfulService.new.events(options)

          it "returns events" do
            expect(events.count).to eq(100)
          end

          it "returns an event with a title" do
            expect(events.first["title"]).to eq("The Reggae Room")
          end

          it "returns an event with categories" do
            expect(events.first["categories"]["category"]).to eq([{"name"=>"Nightlife &amp; Singles", "id"=>"singles_social"}])
          end
        end
      end

      context "multiple options" do
        VCR.use_cassette("eventful_spec/events_with_multiple_overrides") do
          new_options = { date: "2015031000-2015031000",
                          location: "San Francisco" }

          events = EventfulService.new.events(new_options)

          it "returns events" do
            expect(events.count).to eq(100)
          end

          it "returns an event with a title" do
            expect(events.first["title"]).to eq("Mat Kearney")
          end

          it "returns an event with categories" do
            expect(events.first["categories"]["category"]).to eq([{"name"=>"Concerts &amp; Tour Dates", "id"=>"music"}])
          end
        end
      end
    end
  end
  context "categories endpoint" do
    VCR.use_cassette("eventful_spec/categories") do
      categories = EventfulService.new.categories
      it "returns categories" do
        expect(categories.count).to eq(29)
      end

      it "a category has a name" do
        expect(categories.first["name"]).to eq("Concerts & Tour Dates")
      end
    end
  end
end
