class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :url
      t.string :title
      t.string :description
      t.date :start_time
      t.date :end_time
      t.string :venue_name
      t.string :venue_address
      t.boolean :all_day
      t.float :latitude
      t.float :longitude
      t.string :geocode_type

      t.timestamps null: false
    end
  end
end
