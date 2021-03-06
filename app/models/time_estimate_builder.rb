class TimeEstimateBuilder
  def build_estimates
    Neighborhood.all.each do |hood|
      raw_data = get_eta_for(hood)

      raw_data.each do |type|
         build_time_estimate_with(type, hood)
      end
    end
  end

  private

  def get_eta_for(hood)
    latitude = hood.center_point.last
    longitude = hood.center_point.first

    UberService.new(User.first.token).eta_times(start_latitude: latitude,
                                                                start_longitude: longitude)
  end

  def build_time_estimate_with(type, hood)
    hood.time_estimates.create(time: type["estimate"],
                               product_type: type["display_name"])
  end
end
