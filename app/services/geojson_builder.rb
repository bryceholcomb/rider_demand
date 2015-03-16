class GeojsonBuilder
  def self.build(event)
    {
      type: "Feature",
      geometry: {
        type: "Point",
        coordinates: [event.longitude, event.latitude]
      },
      properties: {
        title: event.title,
        description: event.description,
        venue: event.venue_name,
        address: event.venue_address,
        time: event.time_range,
        date: event.date_range,
        image: event.image,
        :"marker-color" => "#00607d",
        :"marker-symbol" => "circle",
        :"marker-size" => "medium"
      }
    }
  end
end
