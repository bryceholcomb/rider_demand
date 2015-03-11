class EventsController < ApplicationController
  def index
    city = params.first.first
    @events = Event.import_events(city)
    @geojson = Array.new
    build_geojson(@events, @geojson)

    respond_to do |format|
      format.html
      format.json { render json: @geojson }
    end
  end

  def build_geojson(events, geojson)
    events.each do |event|
      geojson << {
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
          :"marker-color" => "#00607d",
          :"marker-symbol" => "circle",
          :"marker-size" => "medium"
        }
      }
    end
  end
end
