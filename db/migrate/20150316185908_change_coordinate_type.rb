class ChangeCoordinateType < ActiveRecord::Migration
  def change
    remove_column :neighborhoods, :coordinates
    add_column :neighborhoods, :coordinates, :float, array: true
  end
end
