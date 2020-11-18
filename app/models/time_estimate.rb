class TimeEstimate < ApplicationRecord
  belongs_to :neighborhood

  def minutes
    time / 100
  end

  def self.product_types
    pluck(:product_type).uniq
  end
end
