class Neighborhood < ActiveRecord::Base
  has_many :time_estimates
  belongs_to :city
end
