denver = City.create(name: "Denver", latitude: 39.739, longitude: -104.990)
san_francisco = City.create(name: "San Francisco", latitude: 37.781, longitude: -122.426)

GeojsonParser.new("Denver").perform.each do |neighborhood|
  denver.neighborhoods.build_object(neighborhood)
end

GeojsonParser.new("San Francisco").perform.each do |neighborhood|
  san_francisco.neighborhoods.build_object(neighborhood)
end
