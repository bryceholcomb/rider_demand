class RemoveEtasFromNeighborhood < ActiveRecord::Migration
  def change
    remove_column :neighborhoods, :etas
  end
end
