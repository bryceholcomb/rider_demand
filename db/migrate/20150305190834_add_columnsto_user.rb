class AddColumnstoUser < ActiveRecord::Migration
  def change
    add_column :users, :uber_start_date, :datetime
    add_column :users, :avg_weekly_rides, :integer
  end
end
