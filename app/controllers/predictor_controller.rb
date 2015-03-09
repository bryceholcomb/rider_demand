class PredictorController < ApplicationController
  before_action :authorize!, only: :index

  def index
    @events = Event.all
    @cities = City.all
  end

  def show
    @events = Event.all
    @cities = City.all
  end
end
