class PredictorController < ApplicationController
  before_action :authorize!, only: :index

  def index
    @cities = City.select(:name)
    @categories = Event.category_names_and_ids
    @uber_products = TimeEstimate.product_types
  end

  def show
    @cities = City.select(:name)
    @categories = Event.category_names_and_ids
    @uber_products = TimeEstimate.product_types
  end
end
