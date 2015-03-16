class CreateTimeEstimates < ActiveRecord::Migration
  def change
    create_table :time_estimates do |t|
      t.string :type
      t.integer :time
      t.references :neighborhood, index: true

      t.timestamps null: false
    end
    add_foreign_key :time_estimates, :neighborhoods
  end
end
