class PredictorController < ApplicationController
  before_action :authorize!, only: :index

  def index
    @events = Event.where(venue_city: "Denver")
    @cities = City.all
  end

  def show
    @events = Event.all
    @cities = City.all
  end
end
