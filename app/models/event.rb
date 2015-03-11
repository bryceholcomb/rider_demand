class Event < ActiveRecord::Base
  def format_time(time)
    time.strftime("%l:%M %P")
  end

  def time_range
    "#{format_time(start_time)} - #{format_time(end_time)}"
  end

  def import_events
    options = { app_key: ENV["EVENTFUL_KEY"],
                location: city,
                date: "Today" }
    events = Eventful.new.events(options)
    events.map do |event|
      all_day = if event["all_day"] == 0 ? false : true
      Event.create(url: event["url"],
                   title: event["title"],
                   description: event["description"],
                   venue_name: event["venue_name"],
                   venue_address: event["venue_address"],
                   all_day: all_day,
                   latitude: event["latitude"].to_f,
                   longitude: event["longitude"].to_f,
                   )
    end
  end
end
