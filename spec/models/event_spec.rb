require 'rails_helper'

RSpec.describe Event, :type => :model do
  context "with default options" do
    VCR.use_cassette("event_spec/events_with_date_override") do
      it ".all returns all events for a city happening today" do
        expect(Event.all).to eq("")
      end

      xit "has a formatted time" do
        expect(event.format_time(event.start_time)).to eq(" 8:08 pm")
      end

      xit "has a time range" do
        expect(event.time_range).to eq(" 8:08 pm - 10:08 pm")
      end
    end
  end

  context "with passed in options" do
    VCR.use_cassette("event_spec/events_with_overrides") do
    end
  end
end
