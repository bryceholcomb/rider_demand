class PredictorController < ApplicationController
  before_action :authorize!, only: :index

  def index
    @cities = City.all
  end

  def show
    @cities = City.all
  end
end
