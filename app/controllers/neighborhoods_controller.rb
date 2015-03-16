class NeighborhoodsController < ApplicationController
  def index
    city = City.find_by(name: params["name"])
    @neighborhoods = Neighborhood.where(city: city.id)
    @geojson = Array.new
    build_geojson(@neighborhoods, @geojson)

    respond_to do |format|
      format.html
      format.json { render json: @geojson }
    end
  end

  def build_geojson(neighborhoods, geojson)
    neighborhoods.each do |neighborhood|
      center_point = neighborhood.geometry["coordinates"][0][0][0]

      geojson << {
        type: "Feature",
        geometry: {
          type: "MultiPolygon",
          coordinates: neighborhood.coordinates
        },
        properties: {
          name: neighborhood.name,
          eta: neighborhood.time_estimates.first.time
        }
      }
    end
  end

  def fetch_etas(center_point)
    options = { start_latitude: center_point.last, start_longitude: center_point.first }
    if current_user
      UberService.new(current_user.token).eta_times(options)
    else
      UberService.new(ENV["UBER_DEFAULT_BEARER_TOKEN"]).eta_times(options)
    end
  end
end
