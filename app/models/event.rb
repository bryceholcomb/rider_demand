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
      Event.create()
    end
  end
end
