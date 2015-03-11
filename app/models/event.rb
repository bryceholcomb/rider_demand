class Event
  attr_reader :url, :title, :description, :venue_name, :venue_address,
              :all_day, :latitude, :longitude, :geocode_type, :start_time,
              :end_time, :venue_city, :image, :categories

  def initialize(data)
    @url            = data["url"],
    @title          = data["title"],
    @description    = data["description"],
    @venue_name     = data["venue_name"],
    @venue_address  = data["venue_address"],
    @all_day        = set_all_day_boolean(data["all_day"]),
    @latitude       = data["latitude"].to_f,
    @longitude      = data["longitude"].to_f,
    @geocode_type   = data["geocode_type"],
    @start_time     = set_time(data["start_time"]),
    @end_time       = set_time(data["stop_time"]),
    @venue_city     = data["city_name"],
    @image          = set_image(data["image"])
    @categories     = set_categories(data["categories"]["category"])
  end

  def self.service
    @service ||= EventfulService.new
  end

  def self.where(options = {})
    service.events(options).map { |event| Event.new(event) }
  end

  def format_time(time)
    time ? time.strftime("%l:%M %P") : "unspecified"
  end

  def time_range
    "#{format_time(start_time)} - #{format_time(end_time)}"
  end

  def all_day?
    all_day
  end

  private

  def set_categories(categories)
    categories.map { |category| category["name"] }
  end

  def set_all_day_boolean(number)
    number == 0 ? false : true
  end

  def set_time(time)
    time ? Time.parse(time) : nil
  end

  def set_image(image)
    image ? image["medium"]["url"] : "event_default.png"
  end

  # def self._build_object(data)
  #   OpenStruct.new(data)
  # end
end
