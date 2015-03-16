class Neighborhood < ActiveRecord::Base
  has_many :time_estimates
  belongs_to :city

  store :geometry, accessors: [:coordinates], coder: JSON

  def self.build_object(data)
    Neighborhood.create(name: data["properties"]["name"],
                        geometry: data["geometry"],
                        center_point: data["geometry"]["coordinates"][0][0][0])
  end
end
