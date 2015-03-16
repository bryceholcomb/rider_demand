class ChangeTimeEstimateType < ActiveRecord::Migration
  def change
    remove_column :time_estimates, :type
    remove_column :neighborhoods, :type
    remove_column :neighborhoods, :geometry_type
    add_column :time_estimates, :product_type, :string
  end
end
