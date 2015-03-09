class Event < ActiveRecord::Base
  def format_time(time)
    time.strftime("%l:%M %P")
  end

  def time_range
    "#{format_time(start_time)} - #{format_time(end_time)}"
  end
end
