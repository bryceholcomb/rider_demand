class GeojsonBuilder
  def self.build_event(event)
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

  def self.build_neighborhood(neighborhood, product)
    {
      type: "Feature",
      geometry: {
        type: "MultiPolygon",
        coordinates: neighborhood.coordinates
      },
      properties: {
        name: neighborhood.name,
        eta: neighborhood.current_time_estimate(product).time
      }
    }
  end
end
