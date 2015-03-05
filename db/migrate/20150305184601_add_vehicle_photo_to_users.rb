class AddVehiclePhotoToUsers < ActiveRecord::Migration
  def change
    add_attachment :users, :vehicle_photo
  end
end
