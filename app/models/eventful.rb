class Eventful
  include HTTParty
  base_uri "http://api.eventful.com/json"

  def events(options = {})
    JSON.parse(self.class.get("/events/search", query: options))
  end
end
