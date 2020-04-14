# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# To empty and re-seed, use rake db:reset
User.create(name: "HEIDMANN_SARAH", username: "heidmann_sarah", 
	email: "sarah@heidmann.com", password: "heidmann_sarah", 
	agency: "UVI", active: "true", role: "admin")
User.create(name: "ENNIS_ROSMIN", username: "ennis_rosmin", 
	email: "rosmin@ennis.com", password: "ennis_rosmin", 
	agency: "UVI", active: "true", role: "manager")
User.create(name: "BRANDTNERIS_VIKTOR", username: "brandtneris_viktor", 
	email: "viktor@brandtneris.com", password: "brandtneris_viktor", 
	agency: "UVI", active: "true", role: "user")