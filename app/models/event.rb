class Event < ActiveRecord::Base
  def format_time(time)
    time.strftime("%l:%M %P") if time
  end

  def time_range
    "#{format_time(start_time)} - #{format_time(end_time)}"
  end

  def self.import_events(city)
    options = { app_key: ENV["EVENTFUL_KEY"],
                location: city,
                date: "Today" }
    events = Eventful.new.events(options)
    events.map do |event|
      all_day = event["all_day"] == 0 ? false : true
      stop_time = event["stop_time"] ? Time.parse(event["stop_time"]) : ""
      image = event["image"] ? event["image"]["medium"]["url"] : ""
      Event.create(url: event["url"],
                   title: event["title"],
                   description: event["description"],
                   venue_name: event["venue_name"],
                   venue_address: event["venue_address"],
                   all_day: all_day,
                   latitude: event["latitude"].to_f,
                   longitude: event["longitude"].to_f,
                   geocode_type: event["geocode_type"],
                   start_time: Time.parse(event["start_time"]),
                   end_time: stop_time,
                   venue_city: event["city_name"],
                   image: image)
    end
  end
end
