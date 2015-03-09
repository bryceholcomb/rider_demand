class AddVenueCityToEvents < ActiveRecord::Migration
  def change
    add_column :events, :venue_city, :string
  end
end
