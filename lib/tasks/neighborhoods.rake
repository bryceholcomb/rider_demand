namespace :neighborhoods do
  desc "Takes geojson data and creates neighborhood objects in the DB"
  task build: :environment do
    GeojsonParser.new("Denver").perform.each do |neighborhood|
      Neighborhood.build_object(neighborhood, 1)
    end
    GeojsonParser.new("San Francisco").perform.each do |neighborhood|
      Neighborhood.build_object(neighborhood, 2)
    end
  end
end
