class EventfulService
  include HTTParty
  base_uri "http://api.eventful.com/json"

  def default_options
    { app_key: ENV["EVENTFUL_KEY"],
      location: "39.7392, -104.9903",
      within: 20,
      units: "mi",
      include: "categories",
      mature: "normal",
      sort_order: "date",
      sort_direction: "ascending",
      date: "Today" }
  end

  def events(overrides = {})
    events = JSON.parse(self.class.get("/events/search", query: overridden_options(overrides)))
    events["events"]["event"]
  end

  def overridden_options(overrides)
    default_options.update(overrides)
  end
end
