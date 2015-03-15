class NeighborhoodsController < ApplicationController
  def index
    @neighborhoods = Neighborhood.where(city: params["name"])
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
        type: neighborhood["type"],
        geometry: {
          type: neighborhood.geometry["type"],
          coordinates: neighborhood.geometry["coordinates"]
        },
        properties: {
          name: neighborhood.properties["name"],
          eta: fetch_etas(center_point).first["estimate"]
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
