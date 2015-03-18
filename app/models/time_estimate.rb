class TimeEstimate < ActiveRecord::Base
  belongs_to :neighborhood
  scope :unique_types, -> { select(:product_type).uniq }

  def minutes
    time / 100
  end

  def self.product_types
    unique_types.map { |estimate| estimate.product_type }
  end
end
