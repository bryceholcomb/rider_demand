class CreateNeighborhoods < ActiveRecord::Migration
  def change
    create_table :neighborhoods do |t|
      t.string :name
      t.string :etas, array: true
      t.string :geometry_type
      t.integer :coordinates, array: true
      t.integer :center_point, array: true
      t.string :type

      t.timestamps null: false
    end
  end
end
