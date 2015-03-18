class EventsController < ApplicationController
  def index
    city = City.find_by(name: params["city"])
    category_id = params["category_id"]
    options = { location: city.lat_long, category: category_id  }
    @events = Event.where(options)
    @geojson = Array.new
    build_geojson(@events, @geojson)

    respond_to do |format|
      format.html
      format.json { render json: @geojson }
    end
  end

  def build_geojson(events, geojson)
    events.each do |event|
      geojson << GeojsonBuilder.build_event(event)
    end
  end
end
