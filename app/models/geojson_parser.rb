class GeojsonParser
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def perform
    if name == "Denver"
      JSON.parse(File.read("app/data/denver.geojson"))["features"]
    elsif name === "San Francisco"
      JSON.parse(File.read("app/data/san_francisco.geojson"))["features"]
    end
  end
end
