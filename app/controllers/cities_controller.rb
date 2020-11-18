class CitiesController < ApplicationController
  def index
    city = City.find_by(id: params["city_id"])

    respond_to do |format|
      format.html
      format.json { render json: city }
    end
  end
end
