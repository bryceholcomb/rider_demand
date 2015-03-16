class AddGeometryToNeighborhood < ActiveRecord::Migration
  def change
    add_column :neighborhoods, :geometry, :text
  end
end
