class Neighborhood < ActiveRecord::Base
  has_many :time_estimates
  belongs_to :city

  scope :by_product_type, ->(product) { joins(:time_estimates).where('time_estimates.product_type' => product) }

  store :geometry, accessors: [:coordinates], coder: JSON

  def self.build_object(data)
    Neighborhood.create(name: data["properties"]["name"],
                        geometry: data["geometry"],
                        center_point: data["geometry"]["coordinates"][0][0][0])
  end

  def current_time_estimate(type)
    time_estimates.where(product_type: type).order(created_at: :desc).first
  end
end
