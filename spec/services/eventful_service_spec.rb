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
            expect(events.first["title"]).to eq("Summit Fit Dojo Group Fitness & Kickboxing")
          end

          it "returns an event with categories" do
            expect(events.first["categories"]["category"]).to eq([{"name"=>"Health &amp; Wellness", "id"=>"support"}, {"name"=>"Outdoors &amp; Recreation", "id"=>"outdoors_recreation"}])
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
            expect(events.first["title"]).to eq("Newsies - The Musical")
          end

          it "returns an event with categories" do
            expect(events.first["categories"]["category"]).to eq([{"name"=>"Film", "id"=>"movies_film"}, {"name"=>"Performing Arts", "id"=>"performing_arts"}])
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
