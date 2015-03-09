class AddLatLongToCities < ActiveRecord::Migration
  def change
    add_column :cities, :latitude, :float
    add_column :cities, :longitude, :float
  end
end
