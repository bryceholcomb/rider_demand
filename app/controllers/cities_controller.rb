class CitiesController < ApplicationController
  def index
    @city = City.find_by(name: params.first.first)

    respond_to do |format|
      format.html
      format.json { render json: @city }
    end
  end
end
