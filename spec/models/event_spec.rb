require 'rails_helper'

RSpec.describe Event, :type => :model do
  let!(:event) do
    Event.new(title: "New Event",
              description: "It's going to be awesome",
              start_time: Time.new(2015, 3, 6, 20, 8, 8),
              end_time: Time.new(2015, 3, 6, 22, 8, 8))
  end

  it "has a formatted time" do
    expect(event.format_time(event.start_time)).to eq(" 8:08 pm")
  end

  it "has a time range" do
    expect(event.time_range).to eq(" 8:08 pm - 10:08 pm")
  end
end
