class ChangeColumnTypes < ActiveRecord::Migration
  def change
    remove_column :events, :start_time
    remove_column :events, :end_time
    add_column :events, :start_time, :time
    add_column :events, :end_time, :time
  end
end
