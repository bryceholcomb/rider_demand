class CreateUserCities < ActiveRecord::Migration
  def change
    create_table :user_cities do |t|
      t.references :user, index: true
      t.references :city, index: true
    end
    add_foreign_key :user_cities, :users
    add_foreign_key :user_cities, :cities
  end
end
