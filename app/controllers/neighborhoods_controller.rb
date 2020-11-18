class NeighborhoodsController < ApplicationController
  def index
    city = City.find_by(id: params["city_id"])
    product = params["product"]
    @neighborhoods = city.neighborhoods
    @geojson = Array.new
    build_geojson(@neighborhoods, @geojson, product)

    respond_to do |format|
      format.html
      format.json { render json: @geojson }
    end
  end

  def build_geojson(neighborhoods, geojson, product)
    neighborhoods.each do |neighborhood|
      geojson << GeojsonBuilder.build_neighborhood(neighborhood, product)
    end
  end
end
