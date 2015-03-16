class ChangeCenterPointType < ActiveRecord::Migration
  def change
    remove_column :neighborhoods, :center_point
    add_column :neighborhoods, :center_point, :float, array: true
  end
end
