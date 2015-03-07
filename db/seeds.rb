# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Event.create(title: "Awesome Event",
             description: "This is going to be cool",
             start_time: Time.new(2015, 3, 6),
             end_time: Time.new(2015, 3, 6),
             latitude: 39.7392,
             longitude: -104.9903,
             venue_name: "Ogden")
Event.create(title: "Another Event",
             description: "This one is going to be even better",
             start_time: Time.new(2015, 3, 6),
             end_time: Time.new(2015, 3, 6),
             latitude: 39.7362,
             longitude: -104.9800,
             venue_name: "Ogden")
Event.create(title: "Yet Another Event",
             description: "This one is going to be even better",
             start_time: Time.new(2015, 3, 6),
             end_time: Time.new(2015, 3, 6),
             latitude: 39.7342,
             longitude: -104.9703,
             venue_name: "Ogden")
