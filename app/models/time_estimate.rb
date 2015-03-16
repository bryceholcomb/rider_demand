class TimeEstimate < ActiveRecord::Base
  belongs_to :neighborhood

  def minutes
    time / 100
  end
end
