class Neighborhood
  def self.where(options = {})
    data(options[:city]).map { |neighborhood| _build_object(neighborhood) }
  end

  def self.data(city)
    GeojsonParser.new(city).perform
  end

  def self._build_object(data)
    OpenStruct.new(data)
  end
end
