class EventfulService
  include HTTParty
  base_uri "http://api.eventful.com/json"

  def events(options = {})
    response = JSON.parse(self.class.get("/events/search", query: options))
    response["events"]["event"]
  end
end
