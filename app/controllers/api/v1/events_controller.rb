class Api::V1::EventsController < ApplicationController
  def index
    city = City.find_by(name: params["city"])
    category_id = params["category_id"]
    if city && category_id
      options = { location: city.lat_long, category: category_id  }
    elsif category_id
      options = { category: category_id }
    else
      options = {}
    end
    @events = Event.where(options)
    @geojson = Array.new
    build_geojson(@events, @geojson)

    render json: @geojson
  end

  def build_geojson(events, geojson)
    events.each do |event|
      geojson << GeojsonBuilder.build_event(event)
    end
  end
end
